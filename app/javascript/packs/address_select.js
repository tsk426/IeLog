document.addEventListener('DOMContentLoaded', () => {
  const prefectureSelect = document.getElementById('prefecture_select');
  const citySelect = document.getElementById('city_select');

  if (!prefectureSelect || !citySelect) return;

  prefectureSelect.addEventListener('change', (event) => {
    const selectedPref = event.target.value;

    // 追加の際は北海道の書き方をテンプレートに記載
    const cityOptions = {
      '北海道': ['札幌市', '函館市', '旭川市'],
      '東京都': ['千代田区', '新宿区', '渋谷区'],
      '大阪府': ['大阪市北区', '大阪市中央区'],
    };

    const cities = cityOptions[selectedPref] || [];
    citySelect.innerHTML = '';

    cities.forEach((city) => {
      const option = document.createElement('option');
      option.value = city;
      option.text = city;
      citySelect.appendChild(option);
    });
  });
});