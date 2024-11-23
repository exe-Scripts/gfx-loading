const serverIp = "127.0.0.1:30120"



let currentTrack = 0
$(document).ready(function () {
    $.post(`http://${serverIp}/gfx-loading/getConfig`, {},
        function (data, textStatus, jqXHR) {
            if (data) {
                data = JSON.parse(data)
                $(".header-texts > h1").html(data.ServerInfo.ServerName);
                $(".header-texts > p").html(data.ServerInfo.smallTitle);
                $(".server-logo").attr("src", data.ServerInfo.ServerImage);
                $(".server-info-text").html(data.ServerInfo.serverDescription);
                SetUpdates(data.Updates)
                SetKeys(data.Keys)
                SetSocials(data.SocialMedia)
                createAudio(data.Tracks)
            }
        }
    );
    setTimeout(() => {
        $.post(`http://${serverIp}/gfx-loading/getPlayers`, {},
        function (data, textStatus, jqXHR) {
            if (data) {
                data = JSON.parse(data)
                $(".list-player > .player").remove();
                $.each(data, function (k, v) { 
                    const content = `
                    <div class="player">
                        <img class="player-logo" src=${v.image} alt=""> <p>${v.name}</p> <img class="player-icon" src="assets/player-list-icon.png" alt="">
                    </div>
                    `
                    $(".list-player").append(content);
                });
            }
        }
    );
    }, 250);
    
    $.post(`http://${serverIp}/gfx-loading/getInfo`, {},
        function (data, textStatus, jqXHR) {
            if (data) {
                data = JSON.parse(data)
                $(".player-texts > h1").html(data.name);
                $(".infos-player > img").attr("src", data.image);
            }
    });
});

function SetUpdates(updates) {
    $(".update-notes > .update").remove();
    const countObj = $(".updates-nav-button").find(`[data-id="update-notes"] > .button-texts > p`)
    countObj.html(updates.length + " notes found")
    $.each(updates, function (k, v) { 
        const content = `
            <div class="update">
            <div class="header">
                <h1>${v.title}</h1>
                <p>${v.date}</p>
            </div>

            <div class="content">
                <div class="infos">
                    <div class="title">
                        <img src=${v.publishedByImage} alt="">
                        <div class="title-texts">
                            <h1>PUBLISHED BY</h1>
                            <p>${v.publishedBy}</p>
                        </div>
                    </div>
                    <h1>
                        <strong>"</strong>${v.message}<strong>"</strong>
                    </h1>
                </div>
                <div class="images">
                    <img src=${v.image} alt="">
                </div>
            </div>
        </div>
        `
        $(".update-notes").prepend(content);
    });
}

function SetKeys(keys) {
    $(".keys-contain > .keys").remove();
    const countObj = $(".updates-nav-button").find(`[data-id="keys-contain"] > .button-texts > p`)
    countObj.html(Object.keys(keys).length + " keys found")
    $.each(keys, function (k, v) { 
        const content = `
        <div class="keys">
            <div class="key">
                <p>${k}</p>
            </div>
            <div class="text">
                <h1>${v.title}</h1>
                <p>${v.description}</p>
            </div>
        </div>
        `
        $(".keys-contain").append(content);
    });
}

function SetSocials(socials) {
    $(".socials > button").remove();
    const countObj = $(".updates-nav-button").find(`[data-id="social-contain"] > .button-texts > p`)
    countObj.html(socials.length + " accounts found")

    $.each(socials, function (k, v) {
        const content = `
            <button>
                <img src=${v.image} alt="">

                <div class="link">
                    <p>${v.link}</p>
                </div>
            </button>
        `
        $(".socials").append(content);
    })
}

$(document).on("click", ".nav-button", function () {
    const id = $(this).data("id");
    $(".nav-button").removeClass("-active");
    $(".nav-button > img").attr("src", "assets/nav-page.png")
    $(this).find("img").attr("src", "assets/nav-page-active.png")
    $(this).addClass("-active");
    $(".tab").css("display", "none");
    $(`.${id}`).css("display", "flex");
});

$(document).on("click", ".socials > button", function () {
    const link = $(this).find(".link > p").html();
    window.invokeNative('openUrl', "https://www." + link);
});

var count = 0
var thisCount = 0;
const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },

    initFunctionInvoking(data) {
        // document.querySelector('.progress').style.left = '0%';
        document.querySelector('.progress').style.width =
            (data.idx / count) * 100 + '%';
    },

    startDataFileEntries(data) {
        count = data.count;
    },

    performMapLoadFunction(data) {
        ++thisCount;

        // document.querySelector('.progress').style.left = '0%';
        document.querySelector('.progress').style.width =
            (thisCount / count) * 100 + '%';
    },
};

window.addEventListener('message', function (e) {
    (handlers[e.data.eventName] || function () {})(e.data);
});

function createAudio(tracks) {
    var audioElement = document.getElementById('audio');
    audio.addEventListener('timeupdate', function () {
        $(".song-prog > .path").css("width", (audioElement.currentTime / audioElement.duration) * 100 + "%")
    }, false);

    $(".song-info-buttons > h1").html(tracks[0].name)
    $(".song-info-buttons > p").html(tracks[0].singer)
    $(".song-contain > img").attr("src", tracks[0].image)

    
    $(document).on("click", ".button-contain > img", function () { 
        const id = $(this).data("id");
        if (id == "previous") {
            let index = currentTrack - 1
            const newTrack = tracks[index]
            if (newTrack) {
                audioElement.setAttribute("src", newTrack.file)
                audioElement.play();
                currentTrack = index
                $(".song-info-buttons > h1").html(newTrack.name)
                $(".song-info-buttons > p").html(newTrack.singer)
                $(".song-contain > img").attr("src", newTrack.image)
            } else {
                audioElement.setAttribute("src", tracks[tracks.length - 1].file)
                audioElement.play();
                currentTrack = tracks.length - 1
                $(".song-info-buttons > h1").html(tracks[tracks.length - 1].name)
                $(".song-info-buttons > p").html(tracks[tracks.length - 1].singer)
                $(".song-contain > img").attr("src", tracks[tracks.length - 1].image)

            }
        } else if (id == "next") {
            let index = currentTrack + 1
            const newTrack = tracks[index]
            if (newTrack) {
                audioElement.setAttribute("src", newTrack.file)
                audioElement.play();
                currentTrack = index
                $(".song-info-buttons > h1").html(newTrack.name)
                $(".song-info-buttons > p").html(newTrack.singer)
                $(".song-contain > img").attr("src", newTrack.image)

            } else {
                audioElement.setAttribute("src", tracks[0].file)
                audioElement.play();
                currentTrack = 0
                $(".song-info-buttons > h1").html(tracks[0].name)
                $(".song-info-buttons > p").html(tracks[0].singer)
                $(".song-contain > img").attr("src", tracks[0].image)

            }
        } else if (id == "pause") {
            if (audioElement.paused) {
                $(this).attr("src", "assets/pause.png")
                audioElement.play();
            } else {
                $(this).attr("src", "assets/pause-active.png")
                audioElement.pause();
            }
        }
    })
}

$(document).on("input", ".volume-input", function () {
    const volume = $(this).val()
    const audio = document.getElementById('audio');
    audio.volume = volume / 100
})