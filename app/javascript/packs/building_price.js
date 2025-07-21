document.addEventListener('DOMContentLoaded', () => {
  // reviewのnew or editページのみで動かしたい
  const path = location.pathname;

  if (!path.match(/^\/reviews\/new/) && !path.match(/^\/reviews\/\d+\/edit/)) {
    return; // 該当ページ以外では何もしない
  }

  console.log("✅ building_price.js がレビュー投稿ページで読み込まれました");

  const tsuboInput = document.getElementById('tsubo');
  const priceDisplay = document.getElementById('building_price');
  const landInput = document.getElementById('land_price');

  // 最低限必要な要素が存在しない場合は、このJSを実行しない
  if (!tsuboInput || !priceDisplay || !landInput) return;

  // 以下は元のコードと同じ
  const gradeRadios = document.querySelectorAll('input[name="estimate[grade]"]');
  const floorRadios = document.querySelectorAll('input[name="estimate[floor_type]"]');
  const tagCheckboxes = document.querySelectorAll('input[name="selected_tags[]"]');
  const totalDisplay = document.getElementById('total_price');

  const gradePrices = {
    simple: 65,
    standard: 85,
    premium: 120
  };

  const tagPriceMap = {
    "吹き抜け": 200,
    // ...（省略）...
    "修繕費用削減": 0
  };

  const defaultTagPrice = 20;

  function calculateBuildingPrice() {
    const tsubo = parseFloat(tsuboInput?.value) || 0;
    const selectedGrade = document.querySelector('input[name="grade"]:checked')?.value;
    const selectedFloor = document.querySelector('input[name="floor_type"]:checked')?.value;

    let pricePerTsubo = gradePrices[selectedGrade] || 0;
    if (selectedFloor === '1f') pricePerTsubo += 5;

    const total = pricePerTsubo * tsubo;
    priceDisplay.textContent = total.toLocaleString();

    const hiddenBuildingPrice = document.getElementById('hidden_building_price');
    if (hiddenBuildingPrice) hiddenBuildingPrice.value = total;
  }

  function calculateTagAddition() {
    let tagTotal = 0;
    tagCheckboxes.forEach(tag => {
      if (tag.checked) {
        const tagName = tag.value;
        tagTotal += tagPriceMap.hasOwnProperty(tagName) ? tagPriceMap[tagName] : defaultTagPrice;
      }
    });
    return tagTotal;
  }

  function calculateTotalPrice() {
    const buildingPrice = parseFloat(priceDisplay?.textContent.replace(/,/g, '')) || 0;
    const landPrice = parseInt(landInput?.value) || 0;
    const tagAddition = calculateTagAddition();
    const fixedCost = 600;

    const total = buildingPrice + landPrice + tagAddition + fixedCost;
    if (totalDisplay) totalDisplay.textContent = total.toLocaleString() + ' 万円';

    updateHiddenFields(buildingPrice, total); // ← 必要に応じて定義されていれば
  }

  function calculateAll() {
    calculateBuildingPrice();
    calculateTotalPrice();
  }

  if (tsuboInput) tsuboInput.addEventListener('input', calculateAll);
  gradeRadios.forEach(r => r.addEventListener('change', calculateAll));
  if (landInput) landInput.addEventListener('input', calculateTotalPrice);
  tagCheckboxes.forEach(tag => tag.addEventListener('change', calculateTotalPrice));

  calculateAll();
});
