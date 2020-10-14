// ＜実装手順＞
// ①　JSを動かす記述
  // addEventListenerで画面全体を読み込んだ時に発火
  window.addEventListener("load", () => {
    // document.getElementByIdで入力する場所のidを取得
    let price = document.getElementById("item-price");
    // addEventListenerで入力された時に発火させる条件を記載
    price.addEventListener("keyup", () => {
    // getElementByIdと値を取得するための記述
    let amount = document.getElementById("item-price").value;
    // 変数amountに対し計算を行い、innerHTML（もしくはtextContent）で値を（ビューファイルの対応したidへ）貼り付ける
    document.getElementById("add-tax-price").innerHTML = Math.ceil(amount * 0.1);
    document.getElementById("profit").innerHTML = Math.floor(amount * 0.9);
    });
   });