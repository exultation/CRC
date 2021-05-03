
public class CRC32
{
    var POLYNOMIAL : UInt32
    var revrese : Bool
    var _lookupTable : [UInt32] = []
    var inputReversed : Bool
    var resultReversed : Bool
    
    var startValue : UInt32
    var finalXor : UInt32;
    
    
    init(polynom p : UInt32 = 0x04C11DB7, reversed rev : Bool = false , startValue sv : UInt32 = 0xFFFFFFFF , finalXor xor : UInt32 = 0xFFFFFFFF , inputReversed ir : Bool = true , resultReversed rr : Bool = true)
    {
        POLYNOMIAL = p
        revrese = rev
        startValue = sv
        finalXor = xor
        inputReversed = ir
        resultReversed = rr
    }
    
    /**
    It is possible to use a lookuptable for the CRC dividers. Depending on the polynom the
     Lookuptable is created
     */
    public var lookupTable : [UInt32]
    {
        if _lookupTable.count == 0
        {
            _lookupTable = calcLookupTable()
        }
        return _lookupTable
    }
    
    /**
     Reverse a 32 bit Value. Reverse means that the bits a set to reverse order :
     ````
     0x0082 (0b0000000010000010) -> 0x4100 (0b0100000100000000)
     ````
     */
    private func Reverse32(_ val : UInt32) -> UInt32
    {
        var resVal : UInt32 = 0

        for var i in 0..<32
        {
            if ((val & (1 << i)) != 0)
            {
                resVal |= (1 << (31 - i))
            }
        }

        return resVal
    }
    
    private func Reverse8(_ val : UInt8) -> UInt32
    {
        var resVal : UInt8 = 0

        for var i in 0..<8
        {
            if ((val & (1 << i)) != 0)
            {
                resVal |= (1 << (7 - i))
            }
        }

        return UInt32(resVal)
    }

    func calcLookupTable(  ) -> [UInt32]
    {
        let polynom : UInt32 = revrese ? Reverse32(POLYNOMIAL) : POLYNOMIAL
        var remainder : UInt32 = 0
        var crcTable : [UInt32] = []
        for var b : UInt in  0...255
        {
            if !revrese
            {
                remainder = UInt32(b << 24);
                for  _ : UInt8 in 0..<8
                {
                    if ((remainder & 0x80000000) != 0)
                    {
                        let t = (remainder << 1)
                        remainder = t ^ polynom
                    }
                    else
                    {
                        remainder = (remainder << 1)
                    }
                }
            }
            else
            {
                remainder = UInt32(b);
                for  _ : UInt8 in 0..<8
                {
                    if ((remainder & 0x00000001) != 0)
                    {
                        let t = (remainder >> 1)
                        remainder = t ^ polynom
                    }
                    else
                    {
                        remainder = (remainder >> 1)
                    }
                }
            }
            crcTable.append(remainder)
        }
        return crcTable
    }
    
    open func calcCRC(input bytes : [UInt8]) -> UInt32
    {
        var crc : UInt32  = startValue
        for var b in bytes
        {
            let bl : UInt32 = inputReversed ? Reverse8( b ) : UInt32( b )
            let crcXor = crc >> 24
            /* XOR-in next input byte into MSB of crc and get this MSB, that's our new intermediate divident */
            let pos =   (crcXor ^ bl) & 0xff
            
            /* Shift out the MSB used for division per lookuptable and XOR with the remainder */
            
            let crcLeft = crc << 8
            crc = crcLeft ^ lookupTable[Int(pos)]
        }

        let result = crc ^ finalXor
        return resultReversed ? Reverse32(result) : result
    }
}

public class CRC32Posix : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0x04C11DB7 , reversed: rev , startValue: 0, finalXor: 0xFFFFFFFF , inputReversed: false , resultReversed: false )
    }
}

public class CRC32Mpeg2 : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0x04C11DB7 , reversed: rev , startValue: 0xFFFFFFFF , finalXor: 0x0 ,  inputReversed: false , resultReversed: false )

    }
}

public class CRC32Bzip2 : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0x04C11DB7 , reversed: rev , startValue: 0xFFFFFFFF  , finalXor: 0xFFFFFFFF , inputReversed: false , resultReversed: false )

    }
}

public class CRC32_C : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0x1EDC6F41 , reversed: rev , startValue: 0xFFFFFFFF  , finalXor: 0xFFFFFFFF , inputReversed: true , resultReversed: true )

    }
}

public class CRC32_D : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0xA833982B , reversed: rev , startValue: 0xFFFFFFFF  , finalXor: 0xFFFFFFFF , inputReversed: true , resultReversed: true )

    }
}

public class CRC32_Q : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0x814141AB , reversed: rev , startValue: 0x0  , finalXor: 0x0 , inputReversed: false , resultReversed:false )

    }
}

public class CRC32JamCRC : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0x4C11DB7 , reversed: rev , startValue: 0xFFFFFFFF  , finalXor: 0x0 , inputReversed: true  , resultReversed:true )

    }
}

public class CRC32Xfer : CRC32
{
    public init( reversed rev : Bool = false)
    {
        super.init(polynom: 0xAF , reversed: rev , startValue: 0x0  , finalXor: 0x0 , inputReversed: false  , resultReversed:false )

    }
}
