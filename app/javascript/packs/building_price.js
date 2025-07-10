
document.addEventListener('DOMContentLoaded', () => {
  const tsuboInput = document.getElementById('tsubo');
  const priceDisplay = document.getElementById('building_price');
  const gradeRadios = document.querySelectorAll('input[name="grade"]');
  const floorRadios = document.querySelectorAll('input[name="floor_type"]');
  const landInput = document.getElementById('land_price');
  const tagCheckboxes = document.querySelectorAll('input[name="selected_tags[]"]');
  const totalDisplay = document.getElementById('total_price');

  const gradePrices = {
    simple: 65,
    standard: 85,
    premium: 120
  };

  const tagPriceMap = {
    "吹き抜け": 200,
    "天井高": 200,
    "大空間リビング": 200,
    "無垢材": 200,
    "ソーラーパネル": 200,
    "光熱費削減": 200,
    "ガレージ": 200,
    "カーポート": 100,
    "切妻屋根": 100,
    "寄棟屋根": 100,
    "片流れ屋根": 100,
    "陸屋根": 100,
    "方形屋根": 100,
    "差しかけ屋根": 100,
    "入母屋屋根": 100,
    "招き屋根": 100,
    "タイル": 50,
    "スキップフロア": 50,
    "2Fトイレ": 50,
    "2F浴室": 50,
    "生活導線": 0,
    "多世帯住宅": 0,
    "長期優良住宅": 0
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

    const total = buildingPrice + landPrice + tagAddition;
    if (totalDisplay) {
      totalDisplay.textContent = total.toLocaleString() + ' 万円';
    }
  }

  function calculateAll() {
    calculateBuildingPrice();
    calculateTotalPrice();
  }

  if (tsuboInput) tsuboInput.addEventListener('input', calculateAll);
  gradeRadios.forEach(r => r.addEventListener('change', calculateAll));
  floorRadios.forEach(r => r.addEventListener('change', calculateAll));
  if (landInput) landInput.addEventListener('input', calculateTotalPrice);
  tagCheckboxes.forEach(tag => tag.addEventListener('change', calculateTotalPrice));

  calculateAll(); // 初期計算

  document.querySelectorAll('.tag-checkbox').forEach(checkbox => {
    checkbox.addEventListener('change', calculateTotalPrice);
  });
  
});
