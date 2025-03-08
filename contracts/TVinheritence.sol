// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Tv {
    string public brand;
    uint256 public volume;
    bool public isOn;

    modifier isOnTV() {
        require(isOn, "Turn on the TV first");
        _;
    }

    function TvOn() public {
        isOn = true;
    }

    function TvOff() public virtual {
        isOn = false;
    }

    function increaseVolume() public virtual {
        require(volume < 10, "Your volume is 10");
        volume += 1;
    }

    function decreaseVolume() public {
        require(volume > 0, "Your volume is 0");
        volume -= 1;
    }
}

contract smartTv is Tv {
    constructor() {
        brand = "LG";
        volume = 0;
    }

    function TvOff() public override {
        isOn = false;
    }

    function connectWifi() public view isOnTV returns (string memory) {
        return ("Wifi is connected");
    }

    function goToNonAcademy() public view isOnTV returns (string memory) {
        return ("Subscribe to Non-Academy");
    }
}

contract OLEDTV is Tv {
    uint256 Brightness;
    uint256 Contrast;

    constructor() {
        Brightness = 0;
        Contrast = 0;
    }

    function increaseBrightness() public isOnTV {
        Brightness += 1;
    }

    function decreaseBrightness() public isOnTV {
        Brightness -= 1;
    }

    function increaseContrast() public isOnTV {
        Contrast += 1;
    }

    function decreaseContrast() public isOnTV {
        Contrast -= 1;
    }
}

contract GamingTV is Tv {
    bool public gamingMood;

    constructor() {
        gamingMood = false;
    }

    function enableGamingMode() public isOnTV {
        gamingMood = true;
    }

    function disableGamingMode() public isOnTV {
        gamingMood = false;
    }

    function increaseVolume() public override isOnTV {
        require(volume < 10, "Your volume is 10");
        volume += 1;
    }
}
