YaGames
    .init()
    .then(ysdk => {
        console.log('Yandex SDK initialized');
        window.ysdk = ysdk;
    });

function showFullScreenAdv() {
    ysdk.adv.showFullscreenAdv()
}
