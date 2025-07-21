document.addEventListener('turbolinks:load', () => {
  const path = window.location.pathname;

  // Estimate系ページ（/estimates や /estimates/〜）以外では処理しない
  if (!path.match(/^\/estimates(\/|$)/)) return;

  const tsubo = document.getElementById('tsubo');
  const land = document.getElementById('land_price');
  const gradeRadios = document.querySelectorAll('input[name="estimate[grade]"]');
  const floorRadios = document.querySelectorAll('input[name="estimate[floor_type]"]');
  const buildingDisplay = document.getElementById('building_price');
  const totalDisplay = document.getElementById('total_price');
  const hiddenBuilding = document.getElementById('hidden_building_price');
  const hiddenTotal = document.getElementById('hidden_total_price');
  const tagCheckboxes = document.querySelectorAll('.tag-checkbox');

  const gradePrices = { simple: 65, standard: 85, premium: 120 };

  function calc() {
    const t = parseInt(tsubo?.value) || 0;
    const l = parseInt(land?.value) || 0;
    const g = document.querySelector('input[name="estimate[grade]"]:checked')?.value;
    const f = document.querySelector('input[name="estimate[floor_type]"]:checked')?.value;

    let unit = gradePrices[g] || 0;
    if (f === '1f') unit += 5;
    const building = t * unit;

    // タグ加算
    let tagTotal = 0;
    tagCheckboxes.forEach(tag => {
      if (tag.checked) {
        const price = parseInt(tag.dataset.price) || 0;
        tagTotal += price;
      }
    });

    const total = building + l + tagTotal + 600;

    buildingDisplay.textContent = building;
    totalDisplay.textContent = total;
    hiddenBuilding.value = building;
    hiddenTotal.value = total;
  }

  [tsubo, land].forEach(i => i?.addEventListener('input', calc));
  gradeRadios.forEach(i => i.addEventListener('change', calc));
  floorRadios.forEach(i => i.addEventListener('change', calc));
  tagCheckboxes.forEach(tag => tag.addEventListener('change', calc));

  calc();
});
