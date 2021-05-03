import XCTest
@testable import CRC

final class CRCTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
    }
    
    public func Reflect32(_ val : UInt32) -> UInt32
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
    
    func testReflect()
    {
        let z = Reflect32(0x04C11DB7);
    }

    func testLookup()
    {
        let posix = CRC32Posix().calcCRC(input: Array("Hallo".utf8))
        print("posix:\(posix.hex)\n")
        XCTAssertEqual(posix, 0x21B1930B, "Posix crc wrong")
        
        let mpeg = CRC32Mpeg2().calcCRC(input: Array("Hallo".utf8))
        print("mpeg:\(mpeg.hex)\n")
        XCTAssertEqual(mpeg, 0x995ED768, "mpeg crc wrong")
        
        let bzip = CRC32Bzip2().calcCRC(input: Array("Hallo".utf8))
        print("bzip:\(bzip.hex)\n")
        XCTAssertEqual(bzip, 0x66A12897, "bzip crc wrong")
        
        let crc = CRC32().calcCRC(input: Array("Hallo".utf8))
        print("crc:\(crc.hex)\n")
        XCTAssertEqual(crc, 0x78B31ED5, "crc crc wrong")
        
        let crc_c = CRC32_C().calcCRC(input: Array("Hallo".utf8))
        print("crc_c:\(crc_c.hex)\n")
        XCTAssertEqual(crc_c, 0xFAFB3FE8, "crc_c crc wrong")

        let crc_d = CRC32_D().calcCRC(input: Array("Hallo".utf8))
        print("crc_d:\(crc_d.hex)\n")
        XCTAssertEqual(crc_d, 0xB7767D1F, "crc_d crc wrong")

        let crc_q = CRC32_Q().calcCRC(input: Array("Hallo".utf8))
        print("crc_q:\(crc_q.hex)\n")
        XCTAssertEqual(crc_q, 0xDE30069E, "crc_q crc wrong")

        let crc_jam = CRC32JamCRC().calcCRC(input: Array("Hallo".utf8))
        print("crc_jam:\(crc_jam.hex)\n")
        XCTAssertEqual(crc_jam, 0x874CE12A, "crc_jam crc wrong")

        let crc_xfer = CRC32Xfer().calcCRC(input: Array("Hallo".utf8))
        print("crc_xfer:\(crc_xfer.hex)\n")
        XCTAssertEqual(crc_xfer, 0xB6CEF277, "crc_xfer crc wrong")
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}

extension UInt32
{
    var hex : String
    {
        let r = String(format : "0x%X" , self)
        return r
    }
}
