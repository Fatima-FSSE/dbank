import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank { // motoko class and a canister for decentralize app

  stable var currentValue: Float = 100; // making this variable persited using the keywork stable and it will act same as we connect our apps 
                                // to database and save the values persistedly
  currentValue := 100; // := this is a replace/update operator so if we create a stable variable with initial value
                         // and then use this operator ":=" it will replace and update the value of stable variable. 
  Debug.print(debug_show(currentValue));

  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  // in this function "amount" is the input argument and ":Float" is the data type of argument which is Natural number for Nat
  public func topUp(amount: Float){ // this is private function without public key word and only accessible inside the actor class/canistor
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  }; //function needs to be closed with semicolon

  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount; //declaring const tempValue assigning int tempValue: Float and assigning currentValue-amount
    if(tempValue >= 0){
      currentValue -= amount;
    }
    else {
      Debug.print("Amount too large, currentValue less than zero");
    }
    
  };

  public query func checkBalance(): async Float { // this is a function with return type with Float for return type we have to specify it as async and it's
    return currentValue; // read only function that's why its query call function. it will process fast as compared to update calls or methods
  };

  //compound formula
  // A = currentValue ( 1 + 0.01 )ⁿᵘᵐˢᵉᶜ
  // numsec = numberofseconds
  //----------------------
  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  }

}

