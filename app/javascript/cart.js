document.addEventListener('turbolinks:load', () => {
  // カートアイテムの数量を更新するAJAXリクエストの処理
  document.querySelectorAll('.quantity-field').forEach(field => {
    field.addEventListener('change', (event) => {
      const form = event.target.closest('form');
      const data = new FormData(form);
      fetch(form.action, {
        method: form.method,
        body: data,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
        },
      })
      .then(response => response.text())
      .then(html => {
        document.querySelector('#cart').innerHTML = html;
      });
    });
  });

  // カートアイテムを削除するAJAXリクエストの処理
  document.querySelectorAll('.remove-button').forEach(button => {
    button.addEventListener('click', (event) => {
      event.preventDefault();
      const url = event.target.closest('form').action;
      fetch(url, {
        method: 'DELETE',
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        },
      })
      .then(response => response.text())
      .then(html => {
        document.querySelector('#cart').innerHTML = html;
      });
    });
  });
});