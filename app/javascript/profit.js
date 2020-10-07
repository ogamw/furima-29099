function profit() {
  // 要素を取得
  const price = document.getElementById("item-price")
  price.forEach(function (price) {
    if (price.getAttribute("data-load") != null) {
      return null;
    }
    price.setAttribute("data-load", "true");
    // "item-price"に値が入力されたときに実行する処理を定義している
    price.addEventListener("input", () => {
      // どの"item-price"に値が入力されたのか、カスタムデータを利用して取得している
      const priceId = price.getAttribute("item-price");
      // 非同期通信に必要なオブジェクトを生成している
      const XHR = new XMLHttpRequest();
      // openでリクエストを初期化する
      XHR.open("GET", `/price/${priceId}`, true);
      // レスポンスのタイプを指定する
      XHR.responseType = "json";
      // sendでリクエストを送信する
      XHR.send();
      // レスポンスを受け取った時の処理を記述する
      XHR.onload = () => {
        if (XHR.status != 200) {
          // レスポンスの HTTP ステータスを解析し、該当するエラーメッセージをアラートで表示するようにしている
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          // 処理を終了している
          return null;          
        }
        // レスポンスされたデータを変数profitに代入している
        const profit = XHR.response.price;
        if (profit.input === true) {
          // 値が入力されていれば、適切な値を表示するためのカスタムデータを追加している
          price.setAttribute("item-price", "true");
        } else if (profit.input === false) {
          // 未入力状態であれば、カスタムデータを削除している
          price.removeAttribute("item-price");
        }
      };
    });
  });
}
setInterval(check, 1000);