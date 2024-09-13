document.addEventListener('DOMContentLoaded', () => {
  // 数量を増加させる
  document.querySelectorAll('.increment').forEach(button => {
    button.addEventListener('click', () => {
      const input = document.querySelector(`.quantity-field[data-item-id="${button.dataset.itemId}"]`);
      input.value = parseInt(input.value) + 1;
    });
  });

  // 数量を減少させる
  document.querySelectorAll('.decrement').forEach(button => {
    button.addEventListener('click', () => {
      const input = document.querySelector(`.quantity-field[data-item-id="${button.dataset.itemId}"]`);
      if (parseInt(input.value) > 0) {
        input.value = parseInt(input.value) - 1;
      }
    });
  });

  // // カートに追加する
  // document.querySelector('form').addEventListener('submit', (event) => {
  //   event.preventDefault(); // フォームのデフォルト送信を防ぐ

  //   const form = event.target;
  //   const formData = new FormData(form);

  //   fetch(form.action, {
  //     method: form.method,
  //     headers: {
  //       'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  //     },
  //     body: formData
  //   })
  //   .then(response => {
  //     if (response.ok) {
  //       return response.json(); // 必要に応じてレスポンスを処理
  //     } else {
  //       throw new Error('Network response was not ok.');
  //     }
  //   })
  //   .then(data => {
  //     alert('カートに追加されました');
  //     // 必要に応じてUIの更新を行う
  //   })
  //   .catch(error => console.error('Error:', error));
  // });

  // カートに追加する
  document.querySelectorAll('.add-to-cart').forEach(button => {
    button.addEventListener('click', (event) => {
      // カートに追加する商品のIDと数量を取得
      const itemId = event.currentTarget.dataset.itemId;
      const quantity = document.querySelector(`.quantity-field[data-item-id="${itemId}"]`).value;

      // フォームデータを作成
      const formData = new FormData();
      formData.append('item_id', itemId);
      formData.append('quantity', quantity);

      // サーバーにリクエストを送信
      fetch('/cart_items', {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: formData
      })
      .then(response => {
        if (response.ok) {
          alert('カートに追加されました');
        } else {
          throw new Error('Network response was not ok.');
        }
      })
    });
  });
});
