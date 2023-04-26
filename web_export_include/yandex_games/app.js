YaGames
    .init()
    .then(ysdk => {
        console.log('Yandex SDK initialized');
        window.ysdk = ysdk;
    });

function showFullScreenAdv() {
    YaGames.init().then(ysdk => ysdk.adv.showFullscreenAdv());
}
