class Television {
  void turnOn() {
    _illuminateDisplay();
  }

  void _illuminateDisplay() {
    print('illuminate');
  }
}

class Update {
  void updateApp() {
    print('update');
  }
}

class Charge {
  void chargeVip() {
    print('charge');
  }
}

class SmartTelevision extends Television with Update, Charge {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    updateApp();
    chargeVip();
  }

  @override
  void updateApp() {
    // TODO: implement updateApp
    super.updateApp();
    print('update1');
  }

  void _bootNetworkInterface() {
    print('bootNetwork');
  }
}

void main(List<String> args) {
  SmartTelevision().turnOn();
}
