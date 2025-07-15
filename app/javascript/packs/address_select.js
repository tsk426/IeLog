// 都道府県ごとの市区町村データを読み込み
import { citiesByPrefecture } from "./city_data";

document.addEventListener("DOMContentLoaded", () => {
  const prefectureSelect = document.getElementById("prefecture_select"); // 都道府県セレクトボックス
  const citySelect = document.getElementById("city_select");             // 市区町村セレクトボックス

  // どちらかのセレクトボックスが存在しない場合は処理しない
  if (!prefectureSelect || !citySelect) return;

  /**
   * 都道府県に応じて市区町村のセレクトボックスを更新する
   * @param {string} prefecture - 選択された都道府県コード
   * @param {string|null} selectedCity - 編集画面などで事前に選択されている市区町村（任意）
   */
  function updateCities(prefecture, selectedCity = null) {
    // 該当都道府県の市区町村を取得（該当なしなら空配列）
    const cities = citiesByPrefecture[prefecture] || [];

    // セレクトボックスを初期化
    citySelect.innerHTML = "";

    // デフォルトオプション「市区町村を選択」を追加
    const defaultOption = document.createElement("option");
    defaultOption.text = "市区町村を選択";
    defaultOption.value = "";
    citySelect.add(defaultOption);

    // 市区町村リストを追加
    cities.forEach((city) => {
      const option = document.createElement("option");
      option.text = city;
      option.value = city;

      // 事前選択されている市区町村がある場合は選択状態にする
      if (city === selectedCity) option.selected = true;

      citySelect.add(option);
    });
  }

  // 都道府県が変更されたとき → 市区町村セレクトを更新
  prefectureSelect.addEventListener("change", () => {
    updateCities(prefectureSelect.value);
  });

  // 編集画面など初期表示時に市区町村を表示
  const selectedCity = citySelect.dataset.selected; // 例: <select id="city_select" data-selected="横浜市">
  if (prefectureSelect.value) {
    updateCities(prefectureSelect.value, selectedCity);
  }
});
