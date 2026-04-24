<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    <link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Space+Mono:wght@700&display=swap' rel='stylesheet'>
    <style>
        :root {
            --neon-blue: #00d4ff;
            --neon-cyan: #00ffff;
            --neon-gold: #FFD700;
            --dark-bg: #0a0520;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            user-select: none;
            -webkit-tap-highlight-color: transparent;
        }

        html, body {
            width: 100%;
            height: 100%;
            background: #000000;
            font-family: 'Orbitron', sans-serif;
            overflow: hidden;
            position: fixed;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        #miniBtn {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #0f1a3d 0%, #0a0520 100%);
            border-radius: 50%;
            border: 2px solid var(--neon-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 0 25px var(--neon-blue);
            position: relative;
            z-index: 100;
        }

        #miniBtn::before {
            content: '';
            position: absolute;
            inset: -8px;
            border: 1px solid var(--neon-blue);
            border-radius: 50%;
            opacity: 0.5;
            animation: ringPulse 2s ease-in-out infinite;
        }

        #miniBtn img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.9;
            border-radius: 50%;
            filter: brightness(1.1);
        }

        #main {
            width: 90vw;
            max-width: 240px;
            background: #000000;
            border-radius: 15px;
            padding: 10px;
            border: 2px solid var(--neon-blue);
            box-shadow: 0 0 30px var(--neon-blue), 0 0 60px rgba(0, 212, 255, 0.3);
            display: none;
            flex-direction: column;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
            will-change: transform;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px;
            margin-bottom: 6px;
            border-bottom: 1px solid var(--neon-blue);
            background: rgba(0, 212, 255, 0.05);
            border-radius: 8px;
        }

        .brand-title {
            font-weight: 900;
            font-size: 10px;
            color: var(--neon-gold);
            text-shadow: 0 0 10px var(--neon-gold);
            letter-spacing: 1.5px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .brand-title::before {
            content: '';
            width: 6px;
            height: 6px;
            background: var(--neon-blue);
            border-radius: 50%;
            box-shadow: 0 0 10px var(--neon-blue);
        }

        #cls-btn {
            color: var(--neon-blue);
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            text-shadow: 0 0 8px var(--neon-blue);
            transition: 0.2s;
        }

        #cls-btn:active {
            transform: scale(1.2);
        }

        .display-bezel {
            width: 100%;
            height: 100px;
            background: #050210;
            border-radius: 10px;
            padding: 3px;
            border: 1px solid var(--neon-blue);
            box-shadow: 0 0 20px var(--neon-blue), inset 0 0 20px rgba(0, 212, 255, 0.15);
            position: relative;
            margin-bottom: 6px;
        }

        .screen {
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at center, #1a0a40 0%, var(--dark-bg) 100%);
            border-radius: 8px;
            border: 1px solid var(--neon-blue);
            box-shadow: inset 0 0 15px rgba(0, 212, 255, 0.2);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 5px 6px;
        }

        .screen::before {
            content: '';
            position: absolute;
            inset: 0;
            background: repeating-linear-gradient(0deg, rgba(0, 212, 255, 0.08) 0px, rgba(0, 212, 255, 0.08) 1px, transparent 1px, transparent 2px);
            pointer-events: none;
            opacity: 0.3;
            z-index: 5;
        }

        .screen-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
            width: 100%;
            font-size: 8px;
        }

        .status-led {
            color: var(--neon-blue);
            font-weight: 700;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 3px;
            text-shadow: 0 0 8px var(--neon-blue);
        }

        .led-dot {
            width: 5px;
            height: 5px;
            background: var(--neon-blue);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--neon-blue);
            animation: simplePulse 1.5s ease-in-out infinite;
        }

        .period-badge {
            font-family: 'Space Mono', monospace;
            font-size: 7px;
            color: var(--neon-gold);
            text-shadow: 0 0 6px var(--neon-gold);
        }

        .res-big {
            font-weight: 900;
            font-size: 22px;
            color: var(--neon-gold);
            text-shadow: 0 0 15px var(--neon-gold), 0 0 25px var(--neon-blue);
            z-index: 10;
            text-align: center;
            letter-spacing: 1px;
            margin: 3px 0;
            line-height: 1.2;
        }

        .screen-bottom {
            text-align: center;
            z-index: 10;
            font-size: 7px;
        }

        .terminal-text {
            font-family: 'Space Mono', monospace;
            font-size: 7px;
            color: var(--neon-gold);
            letter-spacing: 0.5px;
            text-shadow: 0 0 6px var(--neon-gold);
        }

        .loading-laser {
            position: absolute;
            top: 0;
            left: -10%;
            width: 2px;
            height: 100%;
            background: linear-gradient(90deg, transparent, var(--neon-gold), transparent);
            box-shadow: 0 0 15px 5px var(--neon-blue);
            z-index: 8;
            opacity: 0;
        }

        .laser-scan {
            animation: laserMove 1.2s ease-in-out infinite;
            opacity: 1;
        }

        .btn-wrap {
            display: flex;
            gap: 5px;
            margin-top: 6px;
            width: 100%;
            height: 30px;
        }

        .watch-btn {
            flex: 3;
            background: #000000;
            border: 1px solid var(--neon-blue);
            border-radius: 6px;
            color: var(--neon-gold);
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            font-size: 9px;
            letter-spacing: 0.5px;
            cursor: pointer;
            text-shadow: 0 0 8px var(--neon-gold);
            transition: 0.15s;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.2);
            -webkit-user-select: none;
            user-select: none;
            -webkit-touch-callout: none;
        }

        .watch-btn:active {
            background: var(--neon-blue);
            color: #000;
            box-shadow: 0 0 20px var(--neon-blue);
            transform: scale(0.95);
        }

        .btn-secondary {
            flex: 2;
            color: var(--neon-blue);
            background: #000000;
            text-shadow: 0 0 6px var(--neon-blue);
        }

        .btn-tg {
            flex: 1;
            background: transparent;
            border: 1px solid var(--neon-blue);
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.15s;
            box-shadow: 0 0 12px rgba(0, 212, 255, 0.15);
        }

        .btn-tg:active {
            background: var(--neon-blue);
        }

        .btn-tg svg {
            width: 14px;
            height: 14px;
            fill: var(--neon-gold);
            filter: drop-shadow(0 0 5px var(--neon-blue));
        }

        .btn-tg:active svg {
            fill: #000;
            filter: none;
        }

        @keyframes ringPulse {
            0%, 100% { 
                box-shadow: 0 0 0 0 rgba(0, 212, 255, 0.5);
                opacity: 0.8;
            }
            50% { 
                box-shadow: 0 0 0 8px rgba(0, 212, 255, 0.1);
                opacity: 0.5;
            }
        }

        @keyframes simplePulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        @keyframes laserMove {
            0% { left: -10%; }
            100% { left: 110%; }
        }

        .blink {
            animation: blink 1s step-end infinite;
        }

        @keyframes blink {
            50% { opacity: 0; }
        }

        /* Performance */
        #main, #miniBtn, .watch-btn, .btn-tg {
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
        <div class='header'>
            <span class='brand-title'>92 PAK</span>
            <div id='cls-btn' onclick='closeM()'>✕</div>
        </div>
        <div class='display-bezel'>
            <div class='screen' id='innerScreen'></div>
        </div>
        <div id='btnArea1' class='btn-wrap'></div>
        <div id='btnArea2' class='btn-wrap'></div>
    </div>

    <script>
        // ============================================
        // PRODUCTION OPTIMIZATION & MANAGEMENT
        // ============================================

        const AppConfig = {
            debugMode: false,
            enableAnalytics: true,
            enableErrorTracking: true,
            maxStorageItems: 50,
            requestTimeout: 5000,
            debounceDelay: 200
        };

        // Performance Monitoring
        const PerfMon = {
            metrics: {
                fps: 0,
                frameCount: 0,
                lastTime: Date.now(),
                renderTime: 0
            },
            
            init() {
                requestAnimationFrame(this.updateFPS.bind(this));
            },
            
            updateFPS() {
                const now = Date.now();
                this.metrics.frameCount++;
                
                if (now - this.metrics.lastTime >= 1000) {
                    this.metrics.fps = this.metrics.frameCount;
                    this.metrics.frameCount = 0;
                    this.metrics.lastTime = now;
                }
                
                requestAnimationFrame(this.updateFPS.bind(this));
            }
        };

        // Storage Manager
        const StorageManager = {
            prefix: 'PANEL_92_',
            
            set(key, value) {
                try {
                    const data = JSON.stringify(value);
                    localStorage.setItem(this.prefix + key, data);
                    return true;
                } catch(e) {
                    console.warn('Storage set failed:', e);
                    return false;
                }
            },
            
            get(key) {
                try {
                    const data = localStorage.getItem(this.prefix + key);
                    return data ? JSON.parse(data) : null;
                } catch(e) {
                    console.warn('Storage get failed:', e);
                    return null;
                }
            },
            
            remove(key) {
                try {
                    localStorage.removeItem(this.prefix + key);
                    return true;
                } catch(e) {
                    return false;
                }
            }
        };

        // Analytics
        const Analytics = {
            events: [],
            
            track(event, data = {}) {
                if (!AppConfig.enableAnalytics) return;
                
                const eventObj = {
                    event,
                    timestamp: Date.now(),
                    data,
                    fps: PerfMon.metrics.fps
                };
                
                this.events.push(eventObj);
                if (this.events.length > AppConfig.maxStorageItems) {
                    this.events.shift();
                }
                
                StorageManager.set('analytics', this.events);
            },
            
            getReport() {
                return this.events;
            }
        };

        // Error Handler
        const ErrorTracker = {
            errors: [],
            
            capture(errorName, message, stack = '') {
                if (!AppConfig.enableErrorTracking) return;
                
                const error = {
                    name: errorName,
                    message,
                    stack,
                    timestamp: Date.now()
                };
                
                this.errors.push(error);
                if (this.errors.length > 20) {
                    this.errors.shift();
                }
                
                StorageManager.set('errors', this.errors);
            }
        };

        // Global Error Handler
        window.addEventListener('error', (e) => {
            ErrorTracker.capture('Global Error', e.message, e.filename);
        });

        // Utility Functions
        const Utils = {
            throttle(func, wait) {
                let timeout;
                return function(...args) {
                    clearTimeout(timeout);
                    timeout = setTimeout(() => func(...args), wait);
                };
            },
            
            debounce(func, wait) {
                let timeout;
                return function(...args) {
                    clearTimeout(timeout);
                    timeout = setTimeout(() => func(...args), wait);
                };
            },
            
            requestWithTimeout(promise, timeout) {
                return Promise.race([
                    promise,
                    new Promise((_, reject) => 
                        setTimeout(() => reject('Timeout'), timeout)
                    )
                ]);
            }
        };

        // ============================================
        // APPLICATION LOGIC
        // ============================================

        let balance = '0.00';
        let state = 'waiting';
        let results = {};
        let depositPlayed = false;
        let numberUnlocked = StorageManager.get('numberUnlocked') || false;
        let sequence = ['SMALL', 'SMALL', 'SMALL', 'SMALL', 'SMALL', 'BIG', 'BIG', 'BIG', 'BIG', 'BIG'];
        const tgIcon = "<svg viewBox='0 0 24 24'><path d='M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221l-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.446 1.394c-.16.16-.295.295-.605.295l.213-3.054 5.56-5.022c.242-.213-.054-.333-.373-.121l-6.869 4.326-2.96-.924c-.643-.203-.658-.643.136-.953l11.55-4.458c.535-.199 1.005.128.844.943z'/></svg>";

        function getPeriod() {
            const d = new Date();
            const y = d.getUTCFullYear();
            const m = String(d.getUTCMonth() + 1).padStart(2, '0');
            const day = String(d.getUTCDate()).padStart(2, '0');
            const totalMinutes = d.getUTCHours() * 60 + d.getUTCMinutes();
            const periodSuffix = String(10001 + totalMinutes);
            return y + m + day + '1000' + periodSuffix;
        }

        function openM() {
            try {
                document.getElementById('main').style.display = 'flex';
                document.getElementById('miniBtn').style.display = 'none';
                Analytics.track('panel_opened');
                
                if (typeof TeamBridge !== 'undefined') {
                    TeamBridge.resizeView(220, 280);
                }
                
                render();
            } catch(e) {
                ErrorTracker.capture('openM', e.message, e.stack);
            }
        }

        function closeM() {
            try {
                document.getElementById('main').style.display = 'none';
                document.getElementById('miniBtn').style.display = 'flex';
                Analytics.track('panel_closed');
                
                if (typeof TeamBridge !== 'undefined') {
                    TeamBridge.resizeView(75, 75);
                }
            } catch(e) {
                ErrorTracker.capture('closeM', e.message, e.stack);
            }
        }

        function route(r, bal) {
            try {
                balance = bal;
                if (r === 'wingo' && (state === 'scanning' || state === 'result')) return;
                state = r;
                Analytics.track('route_changed', { state: r });
                render();
            } catch(e) {
                ErrorTracker.capture('route', e.message, e.stack);
            }
        }

        function startNum() {
            try {
                const cleanBal = parseFloat(balance.replace(/[^0-9.-]+/g, '')) || 0;
                
                if (cleanBal >= 800) {
                    numberUnlocked = true;
                    StorageManager.set('numberUnlocked', true);
                    Analytics.track('number_mode_unlocked');
                    
                    if (typeof TeamBridge !== 'undefined') {
                        TeamBridge.speak('Number mode unlocked');
                    }
                    render();
                } else {
                    Analytics.track('insufficient_balance', { required: 800, current: cleanBal });
                    
                    if (typeof TeamBridge !== 'undefined') {
                        TeamBridge.speak('Deposit required');
                        TeamBridge.loadUrl('https://www.92pak14.com/#/wallet/Recharge');
                    }
                }
            } catch(e) {
                ErrorTracker.capture('startNum', e.message, e.stack);
            }
        }

        function render() {
            try {
                const screen = document.getElementById('innerScreen');
                const b1 = document.getElementById('btnArea1');
                const b2 = document.getElementById('btnArea2');
                const cleanBal = parseFloat(balance.replace(/[^0-9.-]+/g, '')) || 0;

                if (state === 'scanning' || state === 'result') return;

                const mainActionText = numberUnlocked ? 'NUMBER HACK' : 'INITIATE';
                const btnRow2 = numberUnlocked ? 
                    `<div class='btn-tg' onclick="TeamBridge.openExternal('')">${tgIcon}</div>` : 
                    `<button class='watch-btn btn-secondary' onclick='startNum()'>NUM</button><div class='btn-tg' onclick="TeamBridge.openExternal('')">${tgIcon}</div>`;

                if (state === 'reg') {
                    screen.innerHTML = `<div class='screen-top'><div class='status-led'><span class='led-dot'></span> STATUS</div><div class='period-badge'>REQ</div></div><div class='res-big' style='font-size:16px;'>LOGIN</div><div class='screen-bottom'><div class='terminal-text'>WAIT<span class='blink'>_</span></div></div>`;
                    b1.innerHTML = `<button class='watch-btn' style='pointer-events:none;'>WAITING</button>`;
                    b2.style.display = 'none';
                } else if (cleanBal < 300) {
                    if (!depositPlayed && typeof TeamBridge !== 'undefined') {
                        TeamBridge.playSound('teacher_slex300.mp3');
                        depositPlayed = true;
                    }
                    screen.innerHTML = `<div class='screen-top'><div class='status-led'><span class='led-dot'></span> DENIED</div><div class='period-badge'>ERR</div></div><div class='res-big'>LOW</div><div class='screen-bottom'><div class='terminal-text'>DEPOSIT ₹200+</div></div>`;
                    b1.innerHTML = `<button class='watch-btn' onclick="TeamBridge.loadUrl('https://www.92pak14.com/#/wallet/Recharge')">DEPOSIT</button>`;
                    b2.style.display = 'none';
                } else {
                    depositPlayed = false;
                    if (state === 'wingo') {
                        screen.innerHTML = `<div class='screen-top'><div class='status-led'><span class='led-dot'></span> READY</div><div class='period-badge'>ID:---</div></div><div class='res-big' style='font-size:18px;'>[OK]</div><div class='screen-bottom'><div class='terminal-text'>READY<span class='blink'>_</span></div></div>`;
                        b1.innerHTML = `<button class='watch-btn' onclick='start()'>${mainActionText}</button>`;
                        b2.style.display = 'flex';
                        b2.innerHTML = btnRow2;
                    } else {
                        screen.innerHTML = `<div class='screen-top'><div class='status-led'><span class='led-dot'></span> MODULE</div><div class='period-badge'>AI</div></div><div class='res-big' style='font-size:14px;'>WINGO</div><div class='screen-bottom'><div class='terminal-text'>READY<span class='blink'>_</span></div></div>`;
                        b1.innerHTML = `<button class='watch-btn' onclick="TeamBridge.loadUrl('https://www.92pak14.com/#/saasLottery/WinGo?gameCode=WinGo_30S&lottery=WinGo')">OPEN</button>`;
                        b2.style.display = 'none';
                    }
                }
            } catch(e) {
                ErrorTracker.capture('render', e.message, e.stack);
            }
        }

        function start() {
            try {
                const cp = getPeriod();
                
                if (results[cp]) {
                    Analytics.track('cached_result', { period: cp });
                    showRes(cp);
                    return;
                }
                
                state = 'scanning';
                const screen = document.getElementById('innerScreen');
                const b1 = document.getElementById('btnArea1');
                
                b1.innerHTML = `<button class='watch-btn' style='pointer-events:none;'>SCAN...</button>`;
                screen.innerHTML = `<div class='screen-top'><div class='status-led'><span class='led-dot'></span> UPLINK</div><div class='period-badge'>...</div></div><div class='loading-laser laser-scan'></div><div class='res-big' style='font-size:16px;'>DECRYPT</div><div class='screen-bottom'><div class='terminal-text'>FORCE<span class='blink'>_</span></div></div>`;
                
                Analytics.track('scan_started', { period: cp });
                
                setTimeout(() => {
                    let res = sequence[Math.floor(Math.random() * sequence.length)];
                    if (numberUnlocked) {
                        const num = (res === 'SMALL') ? Math.floor(Math.random() * 5) : (Math.floor(Math.random() * 5) + 5);
                        res = res + ' ' + num;
                    }
                    results[cp] = res;
                    Analytics.track('result_generated', { result: res });
                    showRes(cp);
                }, 2500);
            } catch(e) {
                ErrorTracker.capture('start', e.message, e.stack);
            }
        }

        function showRes(p) {
            try {
                if (state !== 'scanning') return;
                
                state = 'result';
                const val = results[p];
                const screen = document.getElementById('innerScreen');
                const b1 = document.getElementById('btnArea1');
                
                screen.innerHTML = `<div class='screen-top'><div class='status-led'><span class='led-dot'></span> OK</div><div class='period-badge'>ID:${p.slice(-4)}</div></div><div class='res-big'>${val}</div><div class='screen-bottom'><div class='terminal-text'>98.9%</div></div>`;
                b1.innerHTML = `<button class='watch-btn' onclick='start()'>RESCAN</button>`;
                
                Analytics.track('result_displayed', { result: val });
                
                if (typeof TeamBridge !== 'undefined') {
                    TeamBridge.speak(val);
                }
            } catch(e) {
                ErrorTracker.capture('showRes', e.message, e.stack);
            }
        }

        // Initialize
        PerfMon.init();
        Analytics.track('app_initialized');
        render();
    </script>
</body>
</html>
