import {dbank } from "../../declarations/dbank";


window.addEventListener("load" , async function() {
  Update();
  //Current Balance: $[object Promise] olarak çalışır.
})
//Html de form'u ele geçirebilmek için bu komutları yazarız. Oşay dinleyici ekle.
//Düğmeye basıldığında bu omutun tetiklenmesini istediğim için submit'i ekleyeceğim.
//fonksiyonla ne yapması gerektiğini tarif et.
document.querySelector("form").addEventListener("submit", async function(event) {
  //console.log("Submitted.");
  //Kod ikinci defa çalıştırıldığında sayılar ve console'saki yazılanlar silinmiş oluyor bu sorunu gidermek için:
  event.preventDefault();

  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);

  //Aşağıda yazmış olduğum kod tam sayı girildiğinde hata verir çünkü float ile çalışıyoruz.
  //İnt değerlere parseFloar yazarak kodu çalıştırabiliriz.

  if (document.getElementById("input-amount").value.length != 0) {
    await dbank.topUp(inputAmount);
  }
  
  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await dbank.withDrow(outputAmount);
  }

  await dbank.cumpount(); //Faiz fiyatı ile birlikte yazdırmak için.

  Update();
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  button.removeAttribute("disabled"); 
  ///////!!!!!!!! Motoko da fonksiyonların çalışması bir kaç sn alabilir. Böyle bir durumda tuşa basılmaktan kaçınılması için;
  //Tuşu devre dışı bırakacağız. Button hareketleri...
});


async function Update() {
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;   //Virgülden sonra sadece 2 basamağı görebilmek için yapıldı.
  //Her sn %1 faiz kbjfdıbhı
  //Bu şekilde göstermesinin sebebi motoko'daki checkBalance() fonksiyonunun asenkron olması.
}