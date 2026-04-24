<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    <link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Space+Mono:wght@400;700&display=swap' rel='stylesheet'>
    <style>
        :root {
            --neon-red: #ff003c;
            --neon-gold: #FFD700;
            --dark-bg: #1a0005;
            --body-gradient: linear-gradient(135deg, #33000b 0%, #1a0005 50%, #0a0002 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            user-select: none;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background: transparent !important;
            overflow: hidden;
            width: 100vw;
            height: 100vh;
            font-family: 'Orbitron', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        #miniBtn {
            width: 60px;
            height: 60px;
            background: var(--body-gradient);
            border-radius: 50%;
            border: 2px solid var(--neon-red);
            box-shadow: 0 10px 20px rgba(0,0,0,0.9), 0 0 15px rgba(255, 0, 60, 0.6);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            animation: float 3s ease-in-out infinite;
            overflow: hidden;
        }

        #miniBtn img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.9;
        }

        #main {
            width: 220px;
            background: var(--body-gradient);
            border-radius: 20px;
            padding: 12px;
            border: 1.5px solid var(--neon-red);
            box-shadow: 0 20px 50px rgba(0,0,0,0.9), 0 0 15px rgba(255,0,60,0.4), inset 0 0 20px rgba(255,0,60,0.3);
            display: none;
            flex-direction: column;
            position: relative;
            margin: auto;
            animation: popIn 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
        }

        #main::before {
            content: '';
            position: absolute;
            top: -16px;
            left: 50%;
            transform: translateX(-50%);
            width: 90px;
            height: 18px;
            background: linear-gradient(180deg, #220008, #0a0002);
            border-radius: 12px 12px 0 0;
            border: 1.5px solid var(--neon-red);
            border-bottom: none;
            box-shadow: 0 -5px 10px rgba(255,0,60,0.2);
            z-index: -1;
        }

        #main::after {
            content: '';
            position: absolute;
            bottom: -16px;
            left: 50%;
            transform: translateX(-50%);
            width: 90px;
            height: 18px;
            background: linear-gradient(0deg, #220008, #0a0002);
            border-radius: 0 0 12px 12px;
            border: 1.5px solid var(--neon-red);
            border-top: none;
            box-shadow: 0 5px 10px rgba(255,0,60,0.2);
            z-index: -1;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 8px;
            cursor: move;
            margin-bottom: 6px;
            border-bottom: 1px solid rgba(255, 0, 60, 0.4);
        }

        .brand-title {
            font-weight: 900;
            font-size: 11px;
            color: var(--neon-gold);
            text-shadow: 0 0 8px var(--neon-gold);
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .brand-title::before {
            content: '';
            width: 6px;
            height: 6px;
            background: var(--neon-red);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--neon-red);
        }

        #cls-btn {
            color: var(--neon-red);
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            text-shadow: 0 0 5px var(--neon-red);
        }

        .display-bezel {
            width: 100%;
            height: 105px;
            background: #0a0002;
            border-radius: 12px;
            padding: 4px;
            border: 1.5px solid var(--neon-red);
            box-shadow: 0 0 10px rgba(255,0,60,0.3), inset 0 0 20px rgba(255,0,60,0.2);
            position: relative;
        }

        .screen {
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at center, #220005 0%, var(--dark-bg) 100%);
            border-radius: 8px;
            border: 1px solid rgba(255, 0, 60, 0.5);
            box-shadow: inset 0 0 15px rgba(255, 0, 60, 0.3);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 6px 8px;
        }

        .screen::after {
            content: '';
            position: absolute;
            inset: 0;
            background: repeating-linear-gradient(0deg, rgba(0,0,0,0.4) 0px, rgba(0,0,0,0.4) 1px, transparent 1px, transparent 2px);
            pointer-events: none;
            opacity: 0.5;
        }

        .screen-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
            width: 100%;
            white-space: nowrap;
            overflow: hidden;
        }

        .status-led {
            font-size: 9px;
            color: var(--neon-red);
            font-weight: 700;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 4px;
            text-shadow: 0 0 5px var(--neon-red);
        }

        .led-dot {
            width: 5px;
            height: 5px;
            background: var(--neon-red);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--neon-red);
            animation: pulse 1.5s infinite;
        }

        .period-badge {
            font-family: 'Space Mono', monospace;
            font-size: 7.5px;
            color: #fff;
            text-shadow: 0 0 5px rgba(255,255,255,0.5);
            white-space: nowrap;
        }

        .res-big {
            font-weight: 900;
            font-size: 24px;
            color: var(--neon-gold);
            text-shadow: 0 0 15px var(--neon-gold);
            z-index: 10;
            text-align: center;
            white-space: nowrap;
            letter-spacing: 2px;
            margin-top: 4px;
            line-height: 1.2;
        }

        .screen-bottom {
            text-align: center;
            z-index: 10;
        }

        .terminal-text {
            font-family: 'Space Mono', monospace;
            font-size: 8px;
            color: var(--neon-gold);
            letter-spacing: 1px;
            text-shadow: 0 0 5px var(--neon-gold);
        }

        .loading-laser {
            position: absolute;
            top: 0;
            left: -10%;
            width: 2px;
            height: 100%;
            background: #fff;
            box-shadow: 0 0 15px 5px var(--neon-red);
            z-index: 8;
            opacity: 0;
        }

        .laser-scan {
            animation: horizontalScan 1.2s ease-in-out infinite;
            opacity: 1;
        }

        .btn-wrap {
            display: flex;
            gap: 6px;
            margin-top: 8px;
            width: 100%;
            height: 32px;
        }

        .watch-btn {
            flex: 3;
            background: linear-gradient(180deg, #1a0005, #000);
            border: 1px solid #4d0012;
            border-top: 1.5px solid #ff4d79;
            border-radius: 8px;
            color: var(--neon-gold);
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            font-size: 10px;
            letter-spacing: 1px;
            cursor: pointer;
            text-shadow: 0 0 8px rgba(255, 215, 0, 0.6);
            transition: 0.15s;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.5);
        }

        .watch-btn:active {
            transform: scale(0.95);
            background: var(--neon-red);
            color: #fff;
            border-color: var(--neon-red);
            text-shadow: none;
            box-shadow: 0 0 15px var(--neon-red);
        }

        .btn-secondary {
            flex: 2;
            color: #ccc;
            border-top: 1.5px solid #888;
            background: linear-gradient(180deg, #111, #000);
            text-shadow: none;
        }

        .btn-tg {
            flex: 1;
            background: rgba(255, 0, 60, 0.1);
            border: 1px solid #ff003c;
            border-top: 1.5px solid #ff4d79;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.15s;
            box-shadow: inset 0 0 10px rgba(255,0,60,0.2);
        }

        .btn-tg svg {
            width: 16px;
            height: 16px;
            fill: var(--neon-gold);
            filter: drop-shadow(0 0 5px var(--neon-gold));
        }

        .btn-tg:active {
            transform: scale(0.92);
            background: var(--neon-red);
        }

        .btn-tg:active svg {
            fill: #fff;
            filter: none;
        }

        @keyframes popIn {
            0% { opacity: 0; transform: scale(0.9); }
            100% { opacity: 1; transform: scale(1); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        @keyframes horizontalScan {
            0% { left: -10%; }
            100% { left: 110%; }
        }

        .blink {
            animation: blinker 1s step-end infinite;
        }

        @keyframes blinker {
            50% { opacity: 0; }
        }
    </style>
</head>
<body>
    <div id='miniBtn' onclick='openM()'>
        <img src='https://uploads.onecompiler.io/43nrmasw5/44mabm9tk/ChatGPT%20Image%20Apr%2023,%202026,%2006_32_29%20PM.png' alt='AI'>
    </div>

    <div id='main'>
        <div class='header' id='dragHeader'>
            <span class='brand-title'>92 PAK NUMBER PANEL </span>
            <div id='cls-btn' onclick='closeM()'>✕</div>
        </div>
        <div class='display-bezel'>
            <div class='screen' id='innerScreen'></div>
        </div>
        <div id='btnArea1' class='btn-wrap'></div>
        <div id='btnArea2' class='btn-wrap'></div>
    </div>

    <script>
        var balance = '0.00';
        var state = 'waiting';
        var results = {};
        var depositPlayed = false;
        var numberUnlocked = false;
        var sequence = ['SMALL', 'SMALL', 'SMALL', 'SMALL', 'SMALL', 'BIG', 'BIG', 'BIG', 'BIG', 'BIG'];
        var tgIcon = "<svg viewBox='0 0 24 24'><path d='M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221l-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.446 1.394c-.16.16-.295.295-.605.295l.213-3.054 5.56-5.022c.242-.213-.054-.333-.373-.121l-6.869 4.326-2.96-.924c-.643-.203-.658-.643.136-.953l11.55-4.458c.535-.199 1.005.128.844.943z'/></svg>";

        function getP() {
            var d = new Date();
            var y = d.getUTCFullYear();
            var m = String(d.getUTCMonth() + 1).padStart(2, '0');
            var day = String(d.getUTCDate()).padStart(2, '0');
            var totalMinutes = d.getUTCHours() * 60 + d.getUTCMinutes();
            var periodSuffix = String(10001 + totalMinutes);
            return y + m + day + '1000' + periodSuffix;
        }

        function openM() {
            document.getElementById('main').style.display = 'flex';
            document.getElementById('miniBtn').style.display = 'none';
            if (typeof TeamBridge !== 'undefined') TeamBridge.resizeView(240, 310);
            render();
        }

        function closeM() {
            document.getElementById('main').style.display = 'none';
            document.getElementById('miniBtn').style.display = 'flex';
            if (typeof TeamBridge !== 'undefined') TeamBridge.resizeView(75, 75);
        }

        function route(r, bal) {
            balance = bal;
            if (r === 'wingo' && (state === 'scanning' || state === 'result')) return;
            state = r;
            render();
        }

        function startNum() {
            var cleanBal = parseFloat(balance.replace(/[^0-9.-]+/g, '')) || 0;
            if (cleanBal >= 800) {
                numberUnlocked = true;
                if (typeof TeamBridge !== 'undefined') TeamBridge.speak('Number mode unlocked successfully.');
                render();
            } else {
                if (typeof TeamBridge !== 'undefined') {
                    TeamBridge.speak('Number hack active karne ke liye 500 ka deposit karein.');
                    TeamBridge.loadUrl('https://www.92pak14.com/#/wallet/Recharge');
                }
            }
        }

        function render() {
            var screen = document.getElementById('innerScreen');
            var b1 = document.getElementById('btnArea1');
            var b2 = document.getElementById('btnArea2');
            var cleanBal = parseFloat(balance.replace(/[^0-9.-]+/g, '')) || 0;

            if (state == 'scanning' || state == 'result') return;

            var mainActionText = numberUnlocked ? 'START NUMBER HACK' : 'INITIATE HACK';
            var btnRow2 = numberUnlocked ? "<div class='btn-tg' style='flex:1' onclick=\"TeamBridge.openExternal('')\">" + tgIcon + "</div>" : "<button class='watch-btn btn-secondary' onclick='startNum()'>NUM MODE</button><div class='btn-tg' onclick=\"TeamBridge.openExternal('')\">" + tgIcon + "</div>";

            if (state == 'reg') {
                screen.innerHTML = "<div class='screen-top'><div class='status-led' style='color:var(--neon-gold);'><span class='led-dot' style='background:var(--neon-gold);'></span> STATUS</div><div class='period-badge'>SYS_REQ</div></div><div class='res-big' style='font-size:18px;'>LOGIN REQ</div><div class='screen-bottom'><div class='terminal-text'>AWAITING INPUT<span class='blink'>_</span></div></div>";
                b1.innerHTML = "<button class='watch-btn' style='color:#888; border-color:#333; pointer-events:none;'>WAITING...</button>";
                b2.style.display = 'none';
            }
            else if (cleanBal < 300) {
                if (!depositPlayed && typeof TeamBridge !== 'undefined') {
                    TeamBridge.playSound('teacher_slex300.mp3');
                    depositPlayed = true;
                }
                screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> DENIED</div><div class='period-badge'>ERR</div></div><div class='res-big' style='font-size:20px; color:var(--neon-red); text-shadow:0 0 15px var(--neon-red);'>LOW BAL</div><div class='screen-bottom'><div class='terminal-text' style='color:var(--neon-red);'>DEPOSIT ₹200+</div></div>";
                b1.innerHTML = "<button class='watch-btn' onclick=\"TeamBridge.loadUrl('https://www.92pak14.com/#/wallet/Recharge')\">DEPOSIT NOW</button>";
                b2.style.display = 'none';
            }
            else {
                depositPlayed = false;
                if (state === 'wingo') {
                    screen.innerHTML = "<div class='screen-top'><div class='status-led' style='color:#777;'><span class='led-dot' style='background:#777; box-shadow:none;'></span> STANDBY</div><div class='period-badge'>ID: -----</div></div><div class='res-big' style='font-size:20px;'>[ READY ]</div><div class='screen-bottom'><div class='terminal-text'>AWAITING INPUT<span class='blink'>_</span></div></div>";
                    b1.innerHTML = "<button class='watch-btn' onclick='start()'>" + mainActionText + "</button>";
                    b2.style.display = 'flex';
                    b2.innerHTML = btnRow2;
                } else {
                    screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> MODULE</div><div class='period-badge' style='color:var(--neon-gold);'>AI</div></div><div class='res-big' style='font-size:16px;'>OPEN WINGO</div><div class='screen-bottom'><div class='terminal-text'>SYSTEM READY<span class='blink'>_</span></div></div>";
                    b1.innerHTML = "<button class='watch-btn' onclick=\"TeamBridge.loadUrl('https://www.92pak14.com/#/saasLottery/WinGo?gameCode=WinGo_30S&lottery=WinGo')\">OPEN GAME</button>";
                    b2.style.display = 'none';
                }
            }
        }

        function start() {
            var cp = getP();
            if (results[cp]) {
                if (typeof TeamBridge !== 'undefined') TeamBridge.speak('Wait next.');
                showRes(cp);
                return;
            }
            state = 'scanning';
            var screen = document.getElementById('innerScreen');
            var b1 = document.getElementById('btnArea1');
            b1.innerHTML = "<button class='watch-btn' style='color:#888; pointer-events:none;'>SCANNING...</button>";
            screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> UPLINK</div><div class='period-badge' style='color:var(--neon-gold);'>...</div></div><div class='loading-laser laser-scan'></div><div class='res-big' style='font-size: 18px;'>DECRYPTING</div><div class='screen-bottom'><div class='terminal-text'>BRUTEFORCE<span class='blink'>_</span></div></div>";
            setTimeout(function () {
                var res = sequence[Math.floor(Math.random() * sequence.length)];
                if (numberUnlocked) {
                    var num = (res === 'SMALL') ? Math.floor(Math.random() * 5) : (Math.floor(Math.random() * 5) + 5);
                    res = res + ' ' + num;
                }
                results[cp] = res;
                showRes(cp);
            }, 2500);
        }

        function showRes(p) {
            if (state !== 'scanning') return;
            state = 'result';
            var val = results[p];
            var screen = document.getElementById('innerScreen');
            var b1 = document.getElementById('btnArea1');
            var mainActionText = numberUnlocked ? 'START NUMBER HACK' : 'RE-SCAN SYSTEM';
            screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> SECURED</div><div class='period-badge'>ID:" + p + "</div></div><div class='res-big'>" + val + "</div><div class='screen-bottom'><div class='terminal-text'>CONFIDENCE: 98.9%</div></div>";
            b1.innerHTML = "<button class='watch-btn' onclick='start()'>" + mainActionText + "</button>";
            if (typeof TeamBridge !== 'undefined') TeamBridge.speak(val);
        }
    </script>
</body>
</html>
