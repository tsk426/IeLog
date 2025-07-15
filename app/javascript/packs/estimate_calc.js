document.addEventListener('turbolinks:load', () => {
  // フォームの各要素
  const tsubo = document.getElementById('tsubo'); // 坪数入力欄
  const land = document.getElementById('land_price'); // 土地価格入力欄
  const gradeRadios = document.querySelectorAll('input[name="estimate[grade]"]'); // グレード選択ラジオボタン
  const floorRadios = document.querySelectorAll('input[name="estimate[floor_type]"]'); // 階数選択ラジオボタン
  const buildingDisplay = document.getElementById('building_price'); // 建物価格表示欄（リアルタイム表示）
  const totalDisplay = document.getElementById('total_price'); // 合計金額表示欄（リアルタイム表示）
  const hiddenBuilding = document.getElementById('hidden_building_price'); // 建物価格の隠しフィールド（JSでリアルタイム表示をしているため）
  const hiddenTotal = document.getElementById('hidden_total_price'); // 合計金額の隠しフィールド（JSでリアルタイム表示をしているため）

  // 各グレードの坪単価（万円）
  const gradePrices = { 
    simple: 65,    // シンプル
    standard: 85,  // スタンダード
    premium: 120   // プレミアム
  };

  // 金額計算ロジック
  function calc() {
    // 入力値を数値に変換（未入力なら0）
    const t = parseInt(tsubo.value) || 0; // 坪数
    const l = parseInt(land.value) || 0; // 土地価格
    const g = document.querySelector('input[name="estimate[grade]"]:checked')?.value; // グレード
    const f = document.querySelector('input[name="estimate[floor_type]"]:checked')?.value; // 階数

    // 坪単価を取得し、平屋の場合+5万円
    let unit = gradePrices[g] || 0;
    if (f === '1f') unit += 5;

    // 建物価格 = 坪単価 × 坪数
    const building = t * unit;

    // 合計金額 = 建物価格 + 土地価格 + 固定費（600万円）
    const total = building + l + 600;

    // 画面上の表示更新
    buildingDisplay.textContent = building;
    totalDisplay.textContent = total;

    // フォームの隠しフィールドに値を代入（JSでリアルタイム表示をしているため）
    hiddenBuilding.value = building;
    hiddenTotal.value = total;
  }

  // イベントリスナー登録
  [tsubo, land].forEach(i => i?.addEventListener('input', calc)); // 坪数・土地価格の変更時
  gradeRadios.forEach(i => i.addEventListener('change', calc)); // グレード選択時
  floorRadios.forEach(i => i.addEventListener('change', calc)); // 階数選択時

  calc(); // ページ読み込み時にも初期計算を実行
});
