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
        let kk = CRC32Posix().calcCRC(input: Array("Hallo".utf8))
        let uu = CRC32Mpeg2().calcCRC(input: Array("Hallo".utf8))
        let tt = CRC32Bzip2().calcCRC(input: Array("Hallo".utf8))
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
