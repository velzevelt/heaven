YaGames
    .init()
    .then(ysdk => {
        console.log('Yandex SDK initialized');
        window.ysdk = ysdk;
    });

function showFullScreenAdv() {
    console.log('Ad shoud be showen')
    YaGames.init().then(ysdk => ysdk.adv.showFullscreenAdv())
}
