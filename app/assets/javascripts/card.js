document.addEventListener("DOMContentLoaded", () => {
   // PAY.JPが初期化されていない場合のみ初期化
   if (typeof Payjp === 'undefined') {
  const payjp = Payjp(''); // 公開可能キーを設定
  const elements = payjp.elements();
  const card = elements.create('card'); // カード情報入力欄を作成
  card.mount('#card-element'); // カード情報入力欄をマウント

  document.getElementById('payment-form').addEventListener('submit', function(event) {
    event.preventDefault();
    payjp.createToken(card).then(function(result) {
      if (result.error) {
        alert(result.error.message);
      } else {
        document.getElementById('payjp_token').value = result.id;
        document.getElementById('payment-form').submit();
      }
    });
  });
} else {
  console.log("PAY.JPは既にインスタンス化されています");
}
});