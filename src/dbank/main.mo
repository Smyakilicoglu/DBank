import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";
//Genelde çoğunun degeri doğal sayıydı veya int'di 
//Faiz kodu çalışmayacağı için Float yapıldı.

actor DbBank {
  //stable === orthogonal persistence(ortogonal kalıcılık) -> Updateler kalıcı olur.
  stable var currentValue: Float = 300;
  currentValue := 300; 
  Debug.print(debug_show(currentValue));
  //Değeri değiştirmek için  := kullanılır. 
  //:= stable bu güncellemede işe yaramaz her çalıştığında currentValue = 100 dönderir.

  //1 ocak 1970'den bu yana kaç ms geçtiyse hesapladı. +1_694_091_639_526_869_819
  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  let id = 881279089487;
  //id := 89767684; let ile yazılan eşitlikler hiç bir şekilde değiştirilemez sabittir.

  //Debug.print(debug_show(id)) //Hata ayıklamak için içe aktar print ile çalıştır.

  // public func topUp() {
  //   currentValue += 1;
  //   Debug.print(debug_show(currentValue))
  // }; //Noktalı virgül kapatmadır olmazsa hata verir.
  
  //girdili bir fonksiyon Nat: --Doğal sayı değerini belirtmemiz lazım
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue))
  };

  public func withDrow(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue))
    } else {
      Debug.print("Amount too large, currentValue less then zero.")
    }
  };

  //Kodda yaptığımız değişiklikleri anında gözlemleyebilmek için kullanırız.
  //currtentValue hangi özellikdese onun özelliğini asenkron olarak fonksiyona atarız.
  public query func checkBalance(): async Float {
    return currentValue;
  };
  //Bu fonksiyon değişkenin değerini hızlı bir şeklde almamızı sağlar.
  //topUp(); //Fonksiyon çağırılmak zorunda.

  public func cumpount() {
    let currentTime = Time.now();
    let timeElapsetNS = currentTime - startTime;
    let timeElapsetS = timeElapsetNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsetS)); //Float sayı Nat ve Int sayıyla çarpılmaz. 1.01 faiz.
    //Her kodu çalıştırdığımızda aynı zaman diliminden başlamaması için;
    startTime := currentTime;
  }
}

//DBank içinde çlalışabilmek için motoko'da actor ifadesi kullanılır.
//Bankadaki parayı 300 olarak başlattık.


//dfx canister call dbank topUp topUp'ı terminalde çağırmak istiyoruz. Kod hemen çalıştı.
//fakat bu çalışmaz çünkü topUp fonksiyonu dbank'ın içinde 
//Satırı çalıştırabilmek için fonksiyonun önüne public eklemeliyiz. İşlev dışarıda çalışabirir hale gelir.


