// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: document.getElementById('map')?.dataset.apiKey
});

async function initShowMap() {
  const mapElement = document.getElementById("map");
  if (!mapElement) return;

  // HTMLの data 属性からその投稿の緯度・経度・タイトルを取得する
  const lat = parseFloat(mapElement.dataset.latitude);
  const lng = parseFloat(mapElement.dataset.longitude);
  const title = mapElement.dataset.title;

  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  // 取得した緯度・経度を中心に地図を初期化
  const map = new Map(mapElement, {
    center: { lat: lat, lng: lng },
    zoom: 16,
    mapId: "DEMO_MAP_ID",
    mapTypeControl: false
  });

  // その投稿の位置にピンを立てる
  new AdvancedMarkerElement({
    position: { lat: lat, lng: lng },
    map,
    title: title,
  });
}

initShowMap();