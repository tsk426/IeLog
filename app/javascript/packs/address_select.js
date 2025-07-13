import { citiesByPrefecture } from "./city_data";

document.addEventListener("DOMContentLoaded", () => {
  const prefectureSelect = document.getElementById("prefecture_select");
  const citySelect = document.getElementById("city_select");

  if (!prefectureSelect || !citySelect) return;

  // 市区町村セレクトを更新する関数
  function updateCities(prefecture, selectedCity = null) {
    const cities = citiesByPrefecture[prefecture] || [];
    citySelect.innerHTML = "";

    // デフォルトの空オプション
    const defaultOption = document.createElement("option");
    defaultOption.text = "市区町村を選択";
    defaultOption.value = "";
    citySelect.add(defaultOption);

    // 市区町村追加
    cities.forEach((city) => {
      const option = document.createElement("option");
      option.text = city;
      option.value = city;
      if (city === selectedCity) option.selected = true;
      citySelect.add(option);
    });
  }

  // 都道府県選択時のイベント
  prefectureSelect.addEventListener("change", () => {
    updateCities(prefectureSelect.value);
  });

  // 編集画面など初期表示対応
  const selectedCity = citySelect.dataset.selected;
  if (prefectureSelect.value) {
    updateCities(prefectureSelect.value, selectedCity);
  }
});
