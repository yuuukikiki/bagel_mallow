document.addEventListener("DOMContentLoaded", () => {
   if (!window.payjpInstance) {
    const publicKey = gon.public_key
    const payjp = Payjp(publicKey)
    window.payjpInstance = payjp; // PAY.JPのインスタンスを保存して再利用

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