<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    <link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Space+Mono:wght@400;700&display=swap' rel='stylesheet'>
    <style>
        :root {
            --neon-blue: #00d4ff;
            --neon-cyan: #00ffff;
            --neon-purple: #ff00ff;
            --neon-gold: #FFD700;
            --dark-bg: #0a0520;
            --body-gradient: linear-gradient(135deg, #0f1a3d 0%, #0a0520 50%, #050210 100%);
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
            border: 3px solid var(--neon-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            overflow: hidden;
            position: relative;
            z-index: 10;
        }

        /* Circular Background Glow (Rotating Circle) */
        #miniBtn::before {
            content: '';
            position: absolute;
            inset: -15px;
            background: conic-gradient(from 0deg, var(--neon-blue), var(--neon-cyan), var(--neon-purple), var(--neon-gold), var(--neon-blue));
            border-radius: 50%;
            opacity: 0.6;
            animation: rotatingCircle 8s linear infinite;
            z-index: -1;
        }

        /* Outer Glow Ring */
        #miniBtn::after {
            content: '';
            position: absolute;
            inset: -8px;
            border: 2px solid var(--neon-blue);
            border-radius: 50%;
            opacity: 0.8;
            box-shadow: 0 0 40px var(--neon-blue), 0 0 80px var(--neon-cyan), 0 0 120px var(--neon-purple);
            z-index: -1;
        }

        #miniBtn img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.95;
            filter: drop-shadow(0 0 20px var(--neon-blue));
            z-index: 2;
        }

        #main {
            width: 220px;
            background: var(--body-gradient);
            border-radius: 20px;
            padding: 12px;
            border: 3px solid var(--neon-blue);
            box-shadow: 
                0 0 60px var(--neon-blue), 
                0 0 120px rgba(0, 212, 255, 0.6), 
                0 0 180px rgba(255, 0, 255, 0.4),
                0 30px 60px rgba(0,0,0,0.9), 
                inset 0 0 40px rgba(0, 212, 255, 0.3),
                inset 0 0 80px rgba(255, 0, 255, 0.2);
            display: none;
            flex-direction: column;
            position: relative;
            margin: auto;
            animation: panelGlowPulse 4s ease-in-out infinite;
        }

        #main::before {
            content: '';
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 25px;
            background: linear-gradient(180deg, #0f1a3d, #050210);
            border-radius: 15px 15px 0 0;
            border: 2px solid var(--neon-blue);
            border-bottom: none;
            box-shadow: 0 -20px 40px rgba(0, 212, 255, 0.4), inset 0 0 25px rgba(0, 212, 255, 0.3);
            z-index: -1;
        }

        #main::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 25px;
            background: linear-gradient(0deg, #0f1a3d, #050210);
            border-radius: 0 0 15px 15px;
            border: 2px solid var(--neon-blue);
            border-top: none;
            box-shadow: 0 20px 40px rgba(0, 212, 255, 0.4), inset 0 0 25px rgba(0, 212, 255, 0.3);
            z-index: -1;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 10px;
            cursor: move;
            margin-bottom: 8px;
            border-bottom: 2px solid var(--neon-blue);
            box-shadow: 0 8px 25px rgba(0, 212, 255, 0.3), inset 0 -5px 15px rgba(0, 212, 255, 0.15);
            background: linear-gradient(90deg, rgba(0, 212, 255, 0.15), rgba(255, 0, 255, 0.08));
            border-radius: 8px;
        }

        .brand-title {
            font-weight: 900;
            font-size: 11px;
            color: var(--neon-gold);
            text-shadow: 
                0 0 20px var(--neon-gold), 
                0 0 40px var(--neon-blue),
                0 0 60px var(--neon-cyan);
            letter-spacing: 2px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .brand-title::before {
            content: '';
            width: 8px;
            height: 8px;
            background: var(--neon-blue);
            border-radius: 50%;
            box-shadow: 0 0 20px var(--neon-blue), 0 0 40px rgba(0, 212, 255, 0.7);
        }

        #cls-btn {
            color: var(--neon-blue);
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-shadow: 0 0 15px var(--neon-blue), 0 0 30px var(--neon-cyan);
            transition: 0.3s;
        }

        #cls-btn:hover {
            text-shadow: 0 0 25px var(--neon-blue), 0 0 50px rgba(0, 212, 255, 0.7), 0 0 75px var(--neon-purple);
            transform: scale(1.2) rotate(90deg);
        }

        .display-bezel {
            width: 100%;
            height: 105px;
            background: #050210;
            border-radius: 12px;
            padding: 4px;
            border: 2px solid var(--neon-blue);
            box-shadow: 
                0 0 35px rgba(0, 212, 255, 0.5), 
                inset 0 0 40px rgba(0, 212, 255, 0.3), 
                0 0 60px var(--neon-blue),
                inset 0 0 60px rgba(255, 0, 255, 0.15);
            position: relative;
        }

        .screen {
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at center, #1a0a40 0%, var(--dark-bg) 100%);
            border-radius: 8px;
            border: 1px solid var(--neon-blue);
            box-shadow: 
                inset 0 0 30px rgba(0, 212, 255, 0.4), 
                inset 0 0 60px rgba(0, 212, 255, 0.15),
                inset 0 0 90px rgba(255, 0, 255, 0.12);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 6px 8px;
        }

        .screen::before {
            content: '';
            position: absolute;
            inset: 0;
            background: 
                repeating-linear-gradient(0deg, rgba(0, 212, 255, 0.12) 0px, rgba(0, 212, 255, 0.12) 1px, transparent 1px, transparent 2px),
                repeating-linear-gradient(90deg, rgba(255, 0, 255, 0.08) 0px, rgba(255, 0, 255, 0.08) 1px, transparent 1px, transparent 2px);
            pointer-events: none;
            opacity: 0.7;
            animation: scanlineMove 10s linear infinite;
            z-index: 5;
        }

        .screen::after {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, transparent 0%, rgba(0, 0, 0, 0.4) 100%);
            pointer-events: none;
            z-index: 4;
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
            color: var(--neon-blue);
            font-weight: 700;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 4px;
            text-shadow: 0 0 15px var(--neon-blue), 0 0 30px var(--neon-cyan);
        }

        .led-dot {
            width: 6px;
            height: 6px;
            background: var(--neon-blue);
            border-radius: 50%;
            box-shadow: 0 0 15px var(--neon-blue), 0 0 30px rgba(0, 212, 255, 0.7);
            animation: ledPulse 1.5s ease-in-out infinite;
        }

        .period-badge {
            font-family: 'Space Mono', monospace;
            font-size: 7.5px;
            color: var(--neon-gold);
            text-shadow: 0 0 15px var(--neon-gold), 0 0 30px var(--neon-blue);
            white-space: nowrap;
        }

        .res-big {
            font-weight: 900;
            font-size: 24px;
            color: var(--neon-gold);
            text-shadow: 
                0 0 25px var(--neon-gold), 
                0 0 50px var(--neon-blue),
                0 0 75px var(--neon-cyan);
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
            text-shadow: 0 0 15px var(--neon-gold), 0 0 30px var(--neon-blue);
        }

        .loading-laser {
            position: absolute;
            top: 0;
            left: -10%;
            width: 4px;
            height: 100%;
            background: linear-gradient(90deg, transparent, var(--neon-gold), transparent);
            box-shadow: 0 0 25px 10px var(--neon-blue), 0 0 50px 20px var(--neon-cyan);
            z-index: 8;
            opacity: 0;
        }

        .laser-scan {
            animation: laserScan 1.2s ease-in-out infinite;
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
            background: linear-gradient(180deg, #0f1a3d, #050210);
            border: 2px solid #00d4ff;
            border-top: 2px solid #00ffff;
            border-radius: 8px;
            color: var(--neon-gold);
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            font-size: 10px;
            letter-spacing: 1px;
            cursor: pointer;
            text-shadow: 0 0 20px var(--neon-gold), 0 0 15px var(--neon-blue);
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 
                0 0 25px rgba(0, 212, 255, 0.4), 
                inset 0 0 12px rgba(0, 212, 255, 0.15),
                0 0 40px rgba(255, 0, 255, 0.25);
            position: relative;
            overflow: hidden;
        }

        .watch-btn:hover {
            box-shadow: 
                0 0 45px var(--neon-blue), 
                0 0 75px rgba(0, 212, 255, 0.5), 
                inset 0 0 20px rgba(0, 212, 255, 0.25),
                0 0 100px var(--neon-purple);
            transform: translateY(-2px);
        }

        .watch-btn:active {
            transform: scale(0.95);
            background: linear-gradient(180deg, #00d4ff, #0088cc);
            color: #fff;
            border-color: var(--neon-blue);
            text-shadow: none;
            box-shadow: 
                0 0 45px var(--neon-blue), 
                0 0 90px rgba(0, 212, 255, 0.7),
                inset 0 0 25px rgba(0, 212, 255, 0.4);
        }

        .btn-secondary {
            flex: 2;
            color: var(--neon-blue);
            border-top: 2px solid var(--neon-gold);
            background: linear-gradient(180deg, #0a1a2e, #050210);
            text-shadow: 0 0 15px var(--neon-blue);
            box-shadow: inset 0 0 12px rgba(0, 212, 255, 0.15), 0 0 30px rgba(255, 0, 255, 0.15);
        }

        .btn-tg {
            flex: 1;
            background: rgba(0, 212, 255, 0.12);
            border: 2px solid var(--neon-blue);
            border-top: 2px solid var(--neon-gold);
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.3s;
            box-shadow: 
                0 0 25px rgba(0, 212, 255, 0.3), 
                inset 0 0 12px rgba(0, 212, 255, 0.12),
                0 0 35px rgba(255, 0, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .btn-tg:hover {
            box-shadow: 
                0 0 45px var(--neon-blue), 
                inset 0 0 20px rgba(0, 212, 255, 0.25),
                0 0 70px var(--neon-purple);
        }

        .btn-tg svg {
            width: 16px;
            height: 16px;
            fill: var(--neon-gold);
            filter: drop-shadow(0 0 12px var(--neon-blue)) drop-shadow(0 0 25px var(--neon-cyan));
            z-index: 2;
        }

        .btn-tg:active {
            transform: scale(0.92);
            background: var(--neon-blue);
            box-shadow: 
                0 0 60px var(--neon-blue), 
                0 0 120px rgba(0, 212, 255, 0.7),
                inset 0 0 25px rgba(0, 212, 255, 0.4);
        }

        .btn-tg:active svg {
            fill: #fff;
            filter: drop-shadow(0 0 20px #fff) drop-shadow(0 0 40px var(--neon-blue));
        }

        /* OPTIMIZED ANIMATIONS - REDUCED COUNT, HEAVIER EFFECTS */

        @keyframes rotatingCircle {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes panelGlowPulse {
            0%, 100% { 
                box-shadow: 
                    0 0 60px var(--neon-blue), 
                    0 0 120px rgba(0, 212, 255, 0.6), 
                    0 0 180px rgba(255, 0, 255, 0.4),
                    0 30px 60px rgba(0,0,0,0.9), 
                    inset 0 0 40px rgba(0, 212, 255, 0.3),
                    inset 0 0 80px rgba(255, 0, 255, 0.2);
            }
            50% { 
                box-shadow: 
                    0 0 90px var(--neon-blue), 
                    0 0 180px rgba(0, 212, 255, 0.8), 
                    0 0 270px rgba(255, 0, 255, 0.5),
                    0 30px 60px rgba(0,0,0,0.9), 
                    inset 0 0 60px rgba(0, 212, 255, 0.5),
                    inset 0 0 120px rgba(255, 0, 255, 0.3);
            }
        }

        @keyframes scanlineMove {
            0% { opacity: 0.7; }
            50% { opacity: 0.4; }
            100% { opacity: 0.7; }
        }

        @keyframes ledPulse {
            0%, 100% { 
                box-shadow: 0 0 15px var(--neon-blue), 0 0 30px rgba(0, 212, 255, 0.7);
                transform: scale(1);
            }
            50% { 
                box-shadow: 0 0 30px var(--neon-blue), 0 0 60px rgba(0, 212, 255, 0.9);
                transform: scale(1.3);
            }
        }

        @keyframes laserScan {
            0% { left: -10%; opacity: 1; }
            100% { left: 110%; opacity: 1; }
        }

        .blink {
            animation: blinker 1s step-end infinite;
        }

        @keyframes blinker {
            50% { opacity: 0; }
        }

        /* GPU Acceleration */
        #miniBtn,
        #main,
        .watch-btn,
        .btn-tg {
            will-change: transform, box-shadow;
            transform: translateZ(0);
            backface-visibility: hidden;
            -webkit-font-smoothing: antialiased;
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
                screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> DENIED</div><div class='period-badge'>ERR</div></div><div class='res-big' style='font-size:20px; color:var(--neon-blue); text-shadow:0 0 25px var(--neon-blue), 0 0 50px var(--neon-gold), 0 0 75px var(--neon-cyan);'>LOW BAL</div><div class='screen-bottom'><div class='terminal-text' style='color:var(--neon-blue);'>DEPOSIT ₹200+</div></div>";
                b1.innerHTML = "<button class='watch-btn' onclick=\"TeamBridge.loadUrl('https://www.92pak14.com/#/wallet/Recharge')\">DEPOSIT NOW</button>";
                b2.style.display = 'none';
            }
            else {
                depositPlayed = false;
                if (state === 'wingo') {
                    screen.innerHTML = "<div class='screen-top'><div class='status-led' style='color:#00d4ff;'><span class='led-dot' style='background:#00d4ff; box-shadow:0 0 15px #00d4ff, 0 0 30px rgba(0, 212, 255, 0.7);'></span> STANDBY</div><div class='period-badge'>ID: -----</div></div><div class='res-big' style='font-size:20px;'>[ READY ]</div><div class='screen-bottom'><div class='terminal-text'>AWAITING INPUT<span class='blink'>_</span></div></div>";
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
