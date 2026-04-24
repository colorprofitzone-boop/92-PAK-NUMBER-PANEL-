<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    <link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Space+Mono:wght@400;700&family=Roboto:wght@400;700;900&display=swap' rel='stylesheet'>
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
            box-shadow: 0 0 30px var(--neon-blue), 0 0 60px rgba(0, 212, 255, 0.5), 0 0 90px rgba(0, 212, 255, 0.3), 0 10px 20px rgba(0,0,0,0.9);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            animation: float 3s ease-in-out infinite, glowPulse 2s ease-in-out infinite, rotateGlow 8s linear infinite;
            overflow: hidden;
            position: relative;
        }

        #miniBtn::before {
            content: '';
            position: absolute;
            inset: -5px;
            background: conic-gradient(from 0deg, var(--neon-blue), var(--neon-cyan), var(--neon-purple), var(--neon-blue));
            border-radius: 50%;
            opacity: 0.3;
            animation: spinBorder 4s linear infinite;
            z-index: -1;
        }

        #miniBtn::after {
            content: '';
            position: absolute;
            inset: -8px;
            background: radial-gradient(circle, var(--neon-blue), transparent);
            border-radius: 50%;
            opacity: 0.2;
            animation: expandPulse 2s ease-out infinite;
        }

        #miniBtn img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.9;
            filter: drop-shadow(0 0 15px var(--neon-blue)) drop-shadow(0 0 30px var(--neon-cyan));
            z-index: 2;
        }

        #main {
            width: 220px;
            background: var(--body-gradient);
            border-radius: 20px;
            padding: 12px;
            border: 3px solid var(--neon-blue);
            box-shadow: 
                0 0 40px var(--neon-blue), 
                0 0 80px rgba(0, 212, 255, 0.4), 
                0 0 120px rgba(255, 0, 255, 0.2),
                0 20px 50px rgba(0,0,0,0.9), 
                inset 0 0 30px rgba(0, 212, 255, 0.2),
                inset 0 0 60px rgba(255, 0, 255, 0.1);
            display: none;
            flex-direction: column;
            position: relative;
            margin: auto;
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards, mainGlow 3s ease-in-out infinite, panelShake 4s ease-in-out infinite;
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
            box-shadow: 0 -15px 30px rgba(0, 212, 255, 0.3), inset 0 0 20px rgba(0, 212, 255, 0.2);
            z-index: -1;
            animation: topGlitch 0.1s infinite;
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
            box-shadow: 0 15px 30px rgba(0, 212, 255, 0.3), inset 0 0 20px rgba(0, 212, 255, 0.2);
            z-index: -1;
            animation: bottomGlitch 0.1s infinite;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 10px;
            cursor: move;
            margin-bottom: 8px;
            border-bottom: 2px solid var(--neon-blue);
            box-shadow: 0 5px 20px rgba(0, 212, 255, 0.2), inset 0 -5px 15px rgba(0, 212, 255, 0.1);
            background: linear-gradient(90deg, rgba(0, 212, 255, 0.1), rgba(255, 0, 255, 0.05));
            border-radius: 8px;
            animation: headerPulse 2s ease-in-out infinite;
        }

        .brand-title {
            font-weight: 900;
            font-size: 11px;
            color: var(--neon-gold);
            text-shadow: 
                0 0 15px var(--neon-gold), 
                0 0 30px var(--neon-blue),
                0 0 45px var(--neon-cyan);
            letter-spacing: 2px;
            display: flex;
            align-items: center;
            gap: 5px;
            animation: titleGlow 2s ease-in-out infinite, titleFlicker 0.2s infinite;
        }

        .brand-title::before {
            content: '';
            width: 8px;
            height: 8px;
            background: var(--neon-blue);
            border-radius: 50%;
            box-shadow: 0 0 15px var(--neon-blue), 0 0 30px rgba(0, 212, 255, 0.6);
            animation: dotPulse 1s infinite, dotGlow 1.5s ease-in-out infinite;
        }

        #cls-btn {
            color: var(--neon-blue);
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-shadow: 0 0 10px var(--neon-blue), 0 0 20px var(--neon-cyan);
            transition: 0.2s;
            animation: closeGlow 1.5s ease-in-out infinite;
        }

        #cls-btn:hover {
            text-shadow: 0 0 20px var(--neon-blue), 0 0 40px rgba(0, 212, 255, 0.6), 0 0 60px var(--neon-purple);
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
                0 0 20px rgba(0, 212, 255, 0.4), 
                inset 0 0 30px rgba(0, 212, 255, 0.2), 
                0 0 40px var(--neon-blue),
                inset 0 0 50px rgba(255, 0, 255, 0.1);
            position: relative;
            animation: bezelGlow 2s ease-in-out infinite;
        }

        .screen {
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at center, #1a0a40 0%, var(--dark-bg) 100%);
            border-radius: 8px;
            border: 1px solid var(--neon-blue);
            box-shadow: 
                inset 0 0 25px rgba(0, 212, 255, 0.3), 
                inset 0 0 50px rgba(0, 212, 255, 0.1),
                inset 0 0 75px rgba(255, 0, 255, 0.1);
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
                repeating-linear-gradient(0deg, rgba(0, 212, 255, 0.1) 0px, rgba(0, 212, 255, 0.1) 1px, transparent 1px, transparent 2px),
                repeating-linear-gradient(90deg, rgba(255, 0, 255, 0.05) 0px, rgba(255, 0, 255, 0.05) 1px, transparent 1px, transparent 2px);
            pointer-events: none;
            opacity: 0.8;
            animation: scanlines 8s linear infinite;
            z-index: 5;
        }

        .screen::after {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, transparent 0%, rgba(0, 0, 0, 0.3) 100%);
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
            text-shadow: 0 0 10px var(--neon-blue), 0 0 20px var(--neon-cyan);
            animation: statusFlicker 0.3s infinite;
        }

        .led-dot {
            width: 6px;
            height: 6px;
            background: var(--neon-blue);
            border-radius: 50%;
            box-shadow: 0 0 12px var(--neon-blue), 0 0 24px rgba(0, 212, 255, 0.6);
            animation: pulse 1s infinite, ledGlow 1.5s ease-in-out infinite;
        }

        .period-badge {
            font-family: 'Space Mono', monospace;
            font-size: 7.5px;
            color: var(--neon-gold);
            text-shadow: 0 0 10px var(--neon-gold), 0 0 20px var(--neon-blue);
            white-space: nowrap;
            animation: badgeGlow 1.5s ease-in-out infinite;
        }

        .res-big {
            font-weight: 900;
            font-size: 24px;
            color: var(--neon-gold);
            text-shadow: 
                0 0 20px var(--neon-gold), 
                0 0 40px var(--neon-blue),
                0 0 60px var(--neon-cyan);
            z-index: 10;
            text-align: center;
            white-space: nowrap;
            letter-spacing: 2px;
            margin-top: 4px;
            line-height: 1.2;
            animation: textGlow 2s ease-in-out infinite, textShimmer 3s ease-in-out infinite;
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
            text-shadow: 0 0 10px var(--neon-gold), 0 0 20px var(--neon-blue);
            animation: terminalGlow 1.5s ease-in-out infinite;
        }

        .loading-laser {
            position: absolute;
            top: 0;
            left: -10%;
            width: 3px;
            height: 100%;
            background: linear-gradient(90deg, transparent, var(--neon-gold), transparent);
            box-shadow: 0 0 20px 8px var(--neon-blue), 0 0 40px 15px var(--neon-cyan);
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
            text-shadow: 0 0 15px var(--neon-gold), 0 0 10px var(--neon-blue);
            transition: 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 
                0 0 15px rgba(0, 212, 255, 0.3), 
                inset 0 0 10px rgba(0, 212, 255, 0.1),
                0 0 25px rgba(255, 0, 255, 0.2);
            position: relative;
            overflow: hidden;
            animation: btnGlow 2s ease-in-out infinite;
        }

        .watch-btn::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(90deg, transparent, rgba(0, 212, 255, 0.3), transparent);
            animation: btnShine 3s ease-in-out infinite;
        }

        .watch-btn:hover {
            box-shadow: 
                0 0 30px var(--neon-blue), 
                0 0 50px rgba(0, 212, 255, 0.4), 
                inset 0 0 15px rgba(0, 212, 255, 0.2),
                0 0 70px var(--neon-purple);
            transform: translateY(-2px);
        }

        .watch-btn:active {
            transform: scale(0.95);
            background: linear-gradient(180deg, #00d4ff, #0088cc);
            color: #fff;
            border-color: var(--neon-blue);
            text-shadow: none;
            box-shadow: 
                0 0 30px var(--neon-blue), 
                0 0 60px rgba(0, 212, 255, 0.6),
                inset 0 0 20px rgba(0, 212, 255, 0.3);
        }

        .btn-secondary {
            flex: 2;
            color: var(--neon-blue);
            border-top: 2px solid var(--neon-gold);
            background: linear-gradient(180deg, #0a1a2e, #050210);
            text-shadow: 0 0 10px var(--neon-blue);
            box-shadow: inset 0 0 10px rgba(0, 212, 255, 0.1), 0 0 20px rgba(255, 0, 255, 0.1);
        }

        .btn-tg {
            flex: 1;
            background: rgba(0, 212, 255, 0.1);
            border: 2px solid var(--neon-blue);
            border-top: 2px solid var(--neon-gold);
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s;
            box-shadow: 
                0 0 15px rgba(0, 212, 255, 0.2), 
                inset 0 0 10px rgba(0, 212, 255, 0.1),
                0 0 20px rgba(255, 0, 255, 0.1);
            position: relative;
            overflow: hidden;
            animation: tgGlow 1.5s ease-in-out infinite;
        }

        .btn-tg::before {
            content: '';
            position: absolute;
            inset: -2px;
            background: conic-gradient(from 0deg, var(--neon-blue), var(--neon-cyan), var(--neon-blue));
            border-radius: 8px;
            opacity: 0;
            animation: borderRotate 3s linear infinite;
            z-index: -1;
        }

        .btn-tg:hover {
            box-shadow: 
                0 0 30px var(--neon-blue), 
                inset 0 0 15px rgba(0, 212, 255, 0.2),
                0 0 50px var(--neon-purple);
        }

        .btn-tg svg {
            width: 16px;
            height: 16px;
            fill: var(--neon-gold);
            filter: drop-shadow(0 0 8px var(--neon-blue)) drop-shadow(0 0 15px var(--neon-cyan));
            z-index: 2;
        }

        .btn-tg:active {
            transform: scale(0.92);
            background: var(--neon-blue);
            box-shadow: 
                0 0 40px var(--neon-blue), 
                0 0 80px rgba(0, 212, 255, 0.6),
                inset 0 0 20px rgba(0, 212, 255, 0.3);
        }

        .btn-tg:active svg {
            fill: #fff;
            filter: drop-shadow(0 0 15px #fff) drop-shadow(0 0 30px var(--neon-blue));
        }

        @keyframes popIn {
            0% { opacity: 0; transform: scale(0.6) rotateX(-90deg); }
            100% { opacity: 1; transform: scale(1) rotateX(0deg); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        @keyframes glowPulse {
            0%, 100% { box-shadow: 0 0 30px var(--neon-blue), 0 0 60px rgba(0, 212, 255, 0.5), 0 0 90px rgba(0, 212, 255, 0.3), 0 10px 20px rgba(0,0,0,0.9); }
            50% { box-shadow: 0 0 50px var(--neon-blue), 0 0 100px rgba(0, 212, 255, 0.7), 0 0 150px rgba(0, 212, 255, 0.4), 0 10px 20px rgba(0,0,0,0.9); }
        }

        @keyframes rotateGlow {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes spinBorder {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes expandPulse {
            0% { transform: scale(1); opacity: 0.3; }
            100% { transform: scale(1.8); opacity: 0; }
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        @keyframes horizontalScan {
            0% { left: -10%; }
            100% { left: 110%; }
        }

        @keyframes mainGlow {
            0%, 100% { 
                box-shadow: 
                    0 0 40px var(--neon-blue), 
                    0 0 80px rgba(0, 212, 255, 0.4), 
                    0 0 120px rgba(255, 0, 255, 0.2),
                    0 20px 50px rgba(0,0,0,0.9), 
                    inset 0 0 30px rgba(0, 212, 255, 0.2),
                    inset 0 0 60px rgba(255, 0, 255, 0.1);
            }
            50% { 
                box-shadow: 
                    0 0 60px var(--neon-blue), 
                    0 0 120px rgba(0, 212, 255, 0.6), 
                    0 0 180px rgba(255, 0, 255, 0.3),
                    0 20px 50px rgba(0,0,0,0.9), 
                    inset 0 0 40px rgba(0, 212, 255, 0.3),
                    inset 0 0 80px rgba(255, 0, 255, 0.2);
            }
        }

        @keyframes panelShake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-0.5px); }
            75% { transform: translateX(0.5px); }
        }

        @keyframes titleGlow {
            0%, 100% { text-shadow: 0 0 15px var(--neon-gold), 0 0 30px var(--neon-blue); }
            50% { text-shadow: 0 0 25px var(--neon-gold), 0 0 50px var(--neon-blue), 0 0 70px var(--neon-cyan); }
        }

        @keyframes titleFlicker {
            0% { opacity: 1; }
            19% { opacity: 1; }
            20% { opacity: 0.8; }
            24% { opacity: 1; }
            62% { opacity: 1; }
            64% { opacity: 0.8; }
            100% { opacity: 1; }
        }

        @keyframes dotPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.3); }
        }

        @keyframes dotGlow {
            0%, 100% { box-shadow: 0 0 15px var(--neon-blue), 0 0 30px rgba(0, 212, 255, 0.6); }
            50% { box-shadow: 0 0 25px var(--neon-blue), 0 0 50px rgba(0, 212, 255, 0.8); }
        }

        @keyframes closeGlow {
            0%, 100% { text-shadow: 0 0 10px var(--neon-blue), 0 0 20px var(--neon-cyan); }
            50% { text-shadow: 0 0 20px var(--neon-blue), 0 0 40px var(--neon-cyan), 0 0 60px var(--neon-purple); }
        }

        @keyframes bezelGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(0, 212, 255, 0.4), inset 0 0 30px rgba(0, 212, 255, 0.2), 0 0 40px var(--neon-blue), inset 0 0 50px rgba(255, 0, 255, 0.1); }
            50% { box-shadow: 0 0 40px rgba(0, 212, 255, 0.6), inset 0 0 50px rgba(0, 212, 255, 0.3), 0 0 80px var(--neon-blue), inset 0 0 80px rgba(255, 0, 255, 0.2); }
        }

        @keyframes scanlines {
            0% { opacity: 0.8; }
            50% { opacity: 0.5; }
            100% { opacity: 0.8; }
        }

        @keyframes statusFlicker {
            0% { opacity: 1; }
            19% { opacity: 1; }
            20% { opacity: 0.7; }
            24% { opacity: 1; }
            100% { opacity: 1; }
        }

        @keyframes ledGlow {
            0%, 100% { box-shadow: 0 0 12px var(--neon-blue), 0 0 24px rgba(0, 212, 255, 0.6); }
            50% { box-shadow: 0 0 20px var(--neon-blue), 0 0 40px rgba(0, 212, 255, 0.8); }
        }

        @keyframes badgeGlow {
            0%, 100% { text-shadow: 0 0 10px var(--neon-gold), 0 0 20px var(--neon-blue); }
            50% { text-shadow: 0 0 15px var(--neon-gold), 0 0 30px var(--neon-blue), 0 0 45px var(--neon-cyan); }
        }

        @keyframes textGlow {
            0%, 100% { text-shadow: 0 0 20px var(--neon-gold), 0 0 40px var(--neon-blue), 0 0 60px var(--neon-cyan); }
            50% { text-shadow: 0 0 30px var(--neon-gold), 0 0 60px var(--neon-blue), 0 0 90px var(--neon-cyan); }
        }

        @keyframes textShimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        @keyframes terminalGlow {
            0%, 100% { text-shadow: 0 0 10px var(--neon-gold), 0 0 20px var(--neon-blue); }
            50% { text-shadow: 0 0 15px var(--neon-gold), 0 0 30px var(--neon-blue), 0 0 45px var(--neon-cyan); }
        }

        @keyframes btnGlow {
            0%, 100% { box-shadow: 0 0 15px rgba(0, 212, 255, 0.3), inset 0 0 10px rgba(0, 212, 255, 0.1), 0 0 25px rgba(255, 0, 255, 0.2); }
            50% { box-shadow: 0 0 25px rgba(0, 212, 255, 0.5), inset 0 0 15px rgba(0, 212, 255, 0.2), 0 0 40px rgba(255, 0, 255, 0.3); }
        }

        @keyframes btnShine {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes borderRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes tgGlow {
            0%, 100% { box-shadow: 0 0 15px rgba(0, 212, 255, 0.2), inset 0 0 10px rgba(0, 212, 255, 0.1), 0 0 20px rgba(255, 0, 255, 0.1); }
            50% { box-shadow: 0 0 25px rgba(0, 212, 255, 0.3), inset 0 0 15px rgba(0, 212, 255, 0.2), 0 0 35px rgba(255, 0, 255, 0.2); }
        }

        @keyframes headerPulse {
            0%, 100% { box-shadow: 0 5px 20px rgba(0, 212, 255, 0.2), inset 0 -5px 15px rgba(0, 212, 255, 0.1); }
            50% { box-shadow: 0 5px 30px rgba(0, 212, 255, 0.3), inset 0 -5px 20px rgba(0, 212, 255, 0.2); }
        }

        @keyframes topGlitch {
            0% { transform: translateX(0); }
            20% { transform: translateX(-2px); }
            40% { transform: translateX(2px); }
            60% { transform: translateX(-2px); }
            80% { transform: translateX(2px); }
            100% { transform: translateX(0); }
        }

        @keyframes bottomGlitch {
            0% { transform: translateX(0); }
            20% { transform: translateX(2px); }
            40% { transform: translateX(-2px); }
            60% { transform: translateX(2px); }
            80% { transform: translateX(-2px); }
            100% { transform: translateX(0); }
        }

        .blink {
            animation: blinker 1s step-end infinite;
        }

        @keyframes blinker {
            50% { opacity: 0; }
        }

        /* Production Performance Optimization */
        @media (prefers-reduced-motion: no-preference) {
            * {
                animation-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
            }
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
        // ============================================
        // PRODUCTION SCRIPTS & OPTIMIZATION
        // ============================================

        // Performance monitoring
        const performanceMetrics = {
            fps: 0,
            frameCount: 0,
            lastTime: Date.now()
        };

        // FPS Counter
        function updateFPS() {
            const now = Date.now();
            performanceMetrics.frameCount++;
            
            if (now - performanceMetrics.lastTime >= 1000) {
                performanceMetrics.fps = performanceMetrics.frameCount;
                performanceMetrics.frameCount = 0;
                performanceMetrics.lastTime = now;
            }
            
            requestAnimationFrame(updateFPS);
        }
        updateFPS();

        // Local Storage Manager
        const StorageManager = {
            save: (key, value) => {
                try {
                    localStorage.setItem(`92PAK_${key}`, JSON.stringify(value));
                } catch(e) {
                    console.warn('Storage save failed:', e);
                }
            },
            get: (key) => {
                try {
                    const data = localStorage.getItem(`92PAK_${key}`);
                    return data ? JSON.parse(data) : null;
                } catch(e) {
                    console.warn('Storage get failed:', e);
                    return null;
                }
            },
            remove: (key) => {
                try {
                    localStorage.removeItem(`92PAK_${key}`);
                } catch(e) {
                    console.warn('Storage remove failed:', e);
                }
            }
        };

        // Analytics Tracking
        const AnalyticsTracker = {
            events: [],
            trackEvent: (eventName, eventData = {}) => {
                const event = {
                    name: eventName,
                    timestamp: new Date().toISOString(),
                    data: eventData,
                    userAgent: navigator.userAgent,
                    timezone: Intl.DateTimeFormat().resolvedOptions().timeZone
                };
                
                AnalyticsTracker.events.push(event);
                
                // Store last 50 events
                if (AnalyticsTracker.events.length > 50) {
                    AnalyticsTracker.events.shift();
                }
                
                StorageManager.save('analytics', AnalyticsTracker.events);
            },
            sendAnalytics: async () => {
                if (AnalyticsTracker.events.length > 0) {
                    try {
                        // Send to your analytics server
                        console.log('Analytics:', AnalyticsTracker.events);
                    } catch(e) {
                        console.warn('Analytics send failed:', e);
                    }
                }
            }
        };

        // Error Handler
        const ErrorHandler = {
            errors: [],
            captureError: (errorName, errorMessage, stack = '') => {
                const error = {
                    name: errorName,
                    message: errorMessage,
                    stack: stack,
                    timestamp: new Date().toISOString(),
                    userAgent: navigator.userAgent
                };
                
                ErrorHandler.errors.push(error);
                
                // Store last 20 errors
                if (ErrorHandler.errors.length > 20) {
                    ErrorHandler.errors.shift();
                }
                
                StorageManager.save('errors', ErrorHandler.errors);
            }
        };

        // Global Error Handler
        window.addEventListener('error', (event) => {
            ErrorHandler.captureError(
                'Global Error',
                event.message,
                event.filename + ':' + event.lineno + ':' + event.colno
            );
        });

        // Main Application Variables
        var balance = '0.00';
        var state = 'waiting';
        var results = {};
        var depositPlayed = false;
        var numberUnlocked = StorageManager.get('numberUnlocked') || false;
        var sequence = ['SMALL', 'SMALL', 'SMALL', 'SMALL', 'SMALL', 'BIG', 'BIG', 'BIG', 'BIG', 'BIG'];
        var sessionStart = new Date();
        var requestCount = 0;

        var tgIcon = "<svg viewBox='0 0 24 24'><path d='M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221l-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.446 1.394c-.16.16-.295.295-.605.295l.213-3.054 5.56-5.022c.242-.213-.054-.333-.373-.121l-6.869 4.326-2.96-.924c-.643-.203-.658-.643.136-.953l11.55-4.458c.535-.199 1.005.128.844.943z'/></svg>";

        // Throttle Function
        function throttle(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        // Debounce Function
        function debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        // Request Validator
        function validateRequest(requestType) {
            requestCount++;
            
            // Rate limiting
            if (requestCount > 100) {
                ErrorHandler.captureError('Rate Limit', 'Request limit exceeded');
                return false;
            }
            
            return true;
        }

        // Period Generator
        function getP() {
            var d = new Date();
            var y = d.getUTCFullYear();
            var m = String(d.getUTCMonth() + 1).padStart(2, '0');
            var day = String(d.getUTCDate()).padStart(2, '0');
            var totalMinutes = d.getUTCHours() * 60 + d.getUTCMinutes();
            var periodSuffix = String(10001 + totalMinutes);
            return y + m + day + '1000' + periodSuffix;
        }

        // Open Main Panel
        function openM() {
            try {
                if (!validateRequest('openM')) return;
                
                document.getElementById('main').style.display = 'flex';
                document.getElementById('miniBtn').style.display = 'none';
                
                AnalyticsTracker.trackEvent('panel_opened', {
                    timestamp: new Date().toISOString()
                });
                
                if (typeof TeamBridge !== 'undefined') {
                    TeamBridge.resizeView(240, 310);
                }
                
                render();
            } catch(e) {
                ErrorHandler.captureError('openM Error', e.message, e.stack);
            }
        }

        // Close Main Panel
        function closeM() {
            try {
                if (!validateRequest('closeM')) return;
                
                document.getElementById('main').style.display = 'none';
                document.getElementById('miniBtn').style.display = 'flex';
                
                AnalyticsTracker.trackEvent('panel_closed', {
                    timestamp: new Date().toISOString()
                });
                
                if (typeof TeamBridge !== 'undefined') {
                    TeamBridge.resizeView(75, 75);
                }
            } catch(e) {
                ErrorHandler.captureError('closeM Error', e.message, e.stack);
            }
        }

        // Route Function
        function route(r, bal) {
            try {
                if (!validateRequest('route')) return;
                
                balance = bal;
                if (r === 'wingo' && (state === 'scanning' || state === 'result')) return;
                state = r;
                
                AnalyticsTracker.trackEvent('route_changed', {
                    newState: r,
                    balance: bal
                });
                
                render();
            } catch(e) {
                ErrorHandler.captureError('route Error', e.message, e.stack);
            }
        }

        // Start Number Hack
        function startNum() {
            try {
                if (!validateRequest('startNum')) return;
                
                var cleanBal = parseFloat(balance.replace(/[^0-9.-]+/g, '')) || 0;
                
                if (cleanBal >= 800) {
                    numberUnlocked = true;
                    StorageManager.save('numberUnlocked', true);
                    
                    AnalyticsTracker.trackEvent('number_mode_unlocked', {
                        balance: cleanBal
                    });
                    
                    if (typeof TeamBridge !== 'undefined') {
                        TeamBridge.speak('Number mode unlocked successfully.');
                    }
                    render();
                } else {
                    AnalyticsTracker.trackEvent('number_mode_failed', {
                        balance: cleanBal,
                        required: 800
                    });
                    
                    if (typeof TeamBridge !== 'undefined') {
                        TeamBridge.speak('Number hack active karne ke liye 500 ka deposit karein.');
                        TeamBridge.loadUrl('https://www.92pak14.com/#/wallet/Recharge');
                    }
                }
            } catch(e) {
                ErrorHandler.captureError('startNum Error', e.message, e.stack);
            }
        }

        // Render Function
        function render() {
            try {
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
                    screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> DENIED</div><div class='period-badge'>ERR</div></div><div class='res-big' style='font-size:20px; color:var(--neon-blue); text-shadow:0 0 15px var(--neon-blue), 0 0 30px var(--neon-gold), 0 0 45px var(--neon-cyan);'>LOW BAL</div><div class='screen-bottom'><div class='terminal-text' style='color:var(--neon-blue);'>DEPOSIT ₹200+</div></div>";
                    b1.innerHTML = "<button class='watch-btn' onclick=\"TeamBridge.loadUrl('https://www.92pak14.com/#/wallet/Recharge')\">DEPOSIT NOW</button>";
                    b2.style.display = 'none';
                }
                else {
                    depositPlayed = false;
                    if (state === 'wingo') {
                        screen.innerHTML = "<div class='screen-top'><div class='status-led' style='color:#00d4ff;'><span class='led-dot' style='background:#00d4ff; box-shadow:0 0 12px #00d4ff, 0 0 24px rgba(0, 212, 255, 0.6);'></span> STANDBY</div><div class='period-badge'>ID: -----</div></div><div class='res-big' style='font-size:20px;'>[ READY ]</div><div class='screen-bottom'><div class='terminal-text'>AWAITING INPUT<span class='blink'>_</span></div></div>";
                        b1.innerHTML = "<button class='watch-btn' onclick='start()'>" + mainActionText + "</button>";
                        b2.style.display = 'flex';
                        b2.innerHTML = btnRow2;
                    } else {
                        screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> MODULE</div><div class='period-badge' style='color:var(--neon-gold);'>AI</div></div><div class='res-big' style='font-size:16px;'>OPEN WINGO</div><div class='screen-bottom'><div class='terminal-text'>SYSTEM READY<span class='blink'>_</span></div></div>";
                        b1.innerHTML = "<button class='watch-btn' onclick=\"TeamBridge.loadUrl('https://www.92pak14.com/#/saasLottery/WinGo?gameCode=WinGo_30S&lottery=WinGo')\">OPEN GAME</button>";
                        b2.style.display = 'none';
                    }
                }
            } catch(e) {
                ErrorHandler.captureError('render Error', e.message, e.stack);
            }
        }

        // Start Function
        function start() {
            try {
                if (!validateRequest('start')) return;
                
                var cp = getP();
                
                if (results[cp]) {
                    AnalyticsTracker.trackEvent('result_cached', {
                        period: cp
                    });
                    
                    if (typeof TeamBridge !== 'undefined') {
                        TeamBridge.speak('Wait next.');
                    }
                    showRes(cp);
                    return;
                }
                
                state = 'scanning';
                var screen = document.getElementById('innerScreen');
                var b1 = document.getElementById('btnArea1');
                b1.innerHTML = "<button class='watch-btn' style='color:#888; pointer-events:none;'>SCANNING...</button>";
                screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> UPLINK</div><div class='period-badge' style='color:var(--neon-gold);'>...</div></div><div class='loading-laser laser-scan'></div><div class='res-big' style='font-size: 18px;'>DECRYPTING</div><div class='screen-bottom'><div class='terminal-text'>BRUTEFORCE<span class='blink'>_</span></div></div>";
                
                AnalyticsTracker.trackEvent('scan_started', {
                    period: cp
                });
                
                setTimeout(function () {
                    var res = sequence[Math.floor(Math.random() * sequence.length)];
                    if (numberUnlocked) {
                        var num = (res === 'SMALL') ? Math.floor(Math.random() * 5) : (Math.floor(Math.random() * 5) + 5);
                        res = res + ' ' + num;
                    }
                    results[cp] = res;
                    
                    AnalyticsTracker.trackEvent('result_generated', {
                        period: cp,
                        result: res
                    });
                    
                    showRes(cp);
                }, 2500);
            } catch(e) {
                ErrorHandler.captureError('start Error', e.message, e.stack);
            }
        }

        // Show Result Function
        function showRes(p) {
            try {
                if (state !== 'scanning') return;
                
                state = 'result';
                var val = results[p];
                var screen = document.getElementById('innerScreen');
                var b1 = document.getElementById('btnArea1');
                var mainActionText = numberUnlocked ? 'START NUMBER HACK' : 'RE-SCAN SYSTEM';
                
                screen.innerHTML = "<div class='screen-top'><div class='status-led'><span class='led-dot'></span> SECURED</div><div class='period-badge'>ID:" + p + "</div></div><div class='res-big'>" + val + "</div><div class='screen-bottom'><div class='terminal-text'>CONFIDENCE: 98.9%</div></div>";
                b1.innerHTML = "<button class='watch-btn' onclick='start()'>" + mainActionText + "</button>";
                
                AnalyticsTracker.trackEvent('result_displayed', {
                    period: p,
                    result: val
                });
                
                if (typeof TeamBridge !== 'undefined') {
                    TeamBridge.speak(val);
                }
            } catch(e) {
                ErrorHandler.captureError('showRes Error', e.message, e.stack);
            }
        }

        // Drag and Drop Functionality
        let isDragging = false;
        let currentX;
        let currentY;
        let initialX;
        let initialY;
        const dragHeader = document.getElementById('dragHeader');
        const main = document.getElementById('main');

        dragHeader.addEventListener('mousedown', (e) => {
            isDragging = true;
            initialX = e.clientX - main.offsetLeft;
            initialY = e.clientY - main.offsetTop;
            AnalyticsTracker.trackEvent('drag_started');
        });

        document.addEventListener('mousemove', (e) => {
            if (isDragging) {
                currentX = e.clientX - initialX;
                currentY = e.clientY - initialY;
                main.style.position = 'fixed';
                main.style.left = currentX + 'px';
                main.style.top = currentY + 'px';
            }
        });

        document.addEventListener('mouseup', () => {
            isDragging = false;
            AnalyticsTracker.trackEvent('drag_ended');
        });

        // Auto send analytics every 30 seconds
        setInterval(() => {
            AnalyticsTracker.sendAnalytics();
        }, 30000);

        // Initial render
        render();
    </script>
</body>
</html>
