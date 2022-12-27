// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library UUID {

    // Below is a random semiprime number with 256 bits
    uint constant pq = 98686309634733686614376257523655700182914516739573612855898430044873713577331;

    function uuidgen() internal view returns (bytes memory){
        bytes1[16] memory seventhByteMembers = [bytes1(0x40), bytes1(0x41), bytes1(0x42), bytes1(0x43), bytes1(0x44),bytes1(0x45),bytes1(0x46),bytes1(0x47),bytes1(0x48),bytes1(0x49),bytes1(0x4a),bytes1(0x4b),bytes1(0x4c),bytes1(0x4d),bytes1(0x4e),bytes1(0x4f)];
        bytes16 uuidData = bytes16(keccak256(abi.encodePacked(
                                msg.sender,
                                pq ^ (block.timestamp + 16)
                                )));
        
        bytes memory uuid = abi.encodePacked(uuidData);
        uuid[6]=seventhByteMembers[(block.timestamp+16)/2%16];
        return uuid;
    
    }


    function _bytestostring(bytes memory buffer) internal pure returns (string memory) {

        // Fixed buffer size for hexadecimal conversion
        bytes memory converted = new bytes(buffer.length * 2);

        bytes memory _base = "0123456789abcdef";
        uint i =0 ;
        uint buffLength = buffer.length;
        for (i; i < buffLength; ++i) {
            converted[i * 2] = _base[uint8(buffer[i]) / _base.length];
            converted[i * 2 + 1] = _base[uint8(buffer[i]) % _base.length];
        }

        return string(abi.encodePacked(converted));
    }

    function uuid4() public view returns (string memory){
        return _bytestostring(uuidgen());
    }

    
}
