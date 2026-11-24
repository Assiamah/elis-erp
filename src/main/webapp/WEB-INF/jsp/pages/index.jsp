<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ELIS | Login</title>
<link rel="shortcut icon" href="favicon-16x16.png">
<link rel="stylesheet" href="assets/login/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/login/css/fontawesome-all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{--green-950:#033c2d;--green-900:#064b39;--green-800:#08684c;--green-700:#0b9066;--green-600:#11a875;--green-100:#e8f7ef;--green-50:#f4fbf7;--gold:#f2c55a;--ink:#172b26;--muted:#667a72;--border:#cde8db}
*{box-sizing:border-box}html,body{margin:0;min-height:100%}body{font-family:Inter,sans-serif;color:var(--ink);background:var(--green-50)}
.login-wrapper{display:flex;min-height:100vh}
.login-hero{position:relative;isolation:isolate;flex:1.08;min-height:100vh;display:flex;flex-direction:column;justify-content:center;overflow:hidden;padding:4rem clamp(2.5rem,5vw,6rem);color:white;background:linear-gradient(120deg,rgba(3,60,45,.97),rgba(6,75,57,.93) 45%,rgba(11,144,102,.83)),url('assets/login/img/land-bg.jpg') center/cover no-repeat}
.login-hero:before{content:"";position:absolute;inset:0 0 auto;height:6px;background:linear-gradient(90deg,var(--gold),#ffe8a0,var(--gold))}
.login-hero:after{content:"";position:absolute;z-index:-1;width:600px;height:600px;right:-300px;top:-260px;border:85px solid rgba(255,255,255,.045);border-radius:50%}
.hero-content{position:relative;z-index:1;max-width:630px}.brand-icon{width:70px;height:70px;display:grid;place-items:center;border:1px solid rgba(255,255,255,.25);border-radius:19px;background:rgba(255,255,255,.12);font-size:1.8rem;box-shadow:0 12px 30px rgba(0,0,0,.1);margin-bottom:27px}
.hero-eyebrow{font-size:.74rem;text-transform:uppercase;letter-spacing:.15em;color:#c3f3d8;font-weight:700;margin-bottom:12px}
.login-hero h1{font-family:Poppins,sans-serif;font-size:clamp(2.1rem,3.3vw,3.2rem);font-weight:700;letter-spacing:-.035em;line-height:1.16;margin:0}.login-hero h1 span{color:#92edb7}
.hero-description{max-width:570px;margin:22px 0 0;color:rgba(255,255,255,.83);font-size:.98rem;line-height:1.85}.hero-description strong{color:#fff}
.hero-features{display:flex;gap:10px;flex-wrap:wrap;margin-top:32px}.hero-feature{display:inline-flex;align-items:center;gap:9px;padding:10px 14px;border:1px solid rgba(255,255,255,.19);border-radius:999px;background:rgba(255,255,255,.085);font-size:.76rem;color:#effff6;backdrop-filter:blur(4px)}.hero-feature i{color:#99f1bc}
.security-notice{max-width:540px;display:flex;gap:12px;align-items:flex-start;margin-top:34px;padding:15px 17px;background:rgba(242,197,90,.08);border:1px solid rgba(242,197,90,.29);border-radius:12px}.security-notice>i{color:var(--gold);margin-top:3px}.security-notice div{font-size:.75rem;line-height:1.65;color:#e4f1e9}.security-notice strong{color:#ffe5a3}
.hero-footer{position:absolute;left:clamp(2.5rem,5vw,6rem);bottom:28px;color:rgba(255,255,255,.58);font-size:.72rem}
.login-form-wrapper{position:relative;isolation:isolate;flex:.92;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:42px;overflow:hidden;background:radial-gradient(circle at 85% 5%,rgba(11,144,102,.13),transparent 35%),radial-gradient(circle at 10% 90%,rgba(11,144,102,.1),transparent 30%),linear-gradient(140deg,#f0faf4,#fff 48%,#eaf8f0)}
.login-form-wrapper:before{content:"";position:absolute;z-index:-1;top:-220px;right:-160px;width:420px;height:420px;border:65px solid rgba(11,144,102,.045);border-radius:50%}
.login-card{position:relative;width:100%;max-width:450px;padding:38px 39px 33px;background:rgba(255,255,255,.97);border:1px solid var(--border);border-radius:19px;overflow:hidden;box-shadow:0 22px 60px rgba(6,75,57,.12),0 5px 15px rgba(0,0,0,.025)}
.login-card:before{content:"";position:absolute;inset:0 0 auto;height:6px;background:linear-gradient(90deg,var(--green-900),var(--green-700) 80%,var(--gold))}
.login-card-brand{display:flex;align-items:center;gap:12px;margin-bottom:29px}.login-card-brand-icon{width:46px;height:46px;display:grid;place-items:center;border-radius:12px;background:linear-gradient(135deg,var(--green-900),var(--green-700));color:#fff;font-size:1.15rem;box-shadow:0 7px 16px rgba(6,75,57,.19)}
.login-card-brand-title{font-family:Poppins,sans-serif;color:var(--green-900);font-size:.91rem;font-weight:700;margin:0}.login-card-brand-subtitle{font-size:.67rem;color:var(--muted);margin:1px 0 0}
.login-card h2{font-family:Poppins,sans-serif;color:var(--ink);font-weight:700;font-size:1.7rem;margin:0 0 8px}.login-card>.text-muted{color:var(--muted)!important;font-size:.82rem;line-height:1.6;margin-bottom:26px}
.form-label{font-size:.78rem;font-weight:600;color:#355b4b;margin-bottom:9px}.login-input{position:relative}.login-input-icon{position:absolute;left:15px;top:50%;transform:translateY(-50%);z-index:2;color:#8ba79a;font-size:.95rem;pointer-events:none}
.login-input .form-control{height:50px;border:1px solid #cddbd2;border-radius:11px;background:#fcfefd;color:var(--ink);font-size:.84rem;padding:10px 46px 10px 43px;box-shadow:none;transition:border-color .2s,box-shadow .2s,background .2s}.login-input .form-control::placeholder{color:#97a9a0}.login-input .form-control:hover{border-color:#8ccbad}.login-input .form-control:focus{border-color:var(--green-700);background:#fff;box-shadow:0 0 0 4px rgba(11,144,102,.12)}.login-input:focus-within .login-input-icon{color:var(--green-700)}
.password-toggle{position:absolute;right:13px;top:50%;transform:translateY(-50%);z-index:3;border:0;background:transparent;color:#789688;padding:6px;cursor:pointer}.password-toggle:hover,.password-toggle:focus{color:var(--green-700);outline:2px solid transparent}
.forgot-link{font-size:.76rem;color:var(--green-800);font-weight:600;text-decoration:none}.forgot-link:hover{color:var(--green-950);text-decoration:underline}
.btn-login{display:flex;align-items:center;justify-content:center;gap:11px;width:100%;min-height:51px;border:0;border-radius:11px;color:#fff;background:linear-gradient(110deg,var(--green-900),var(--green-800) 55%,var(--green-700));font-size:.86rem;font-weight:700;box-shadow:0 9px 20px rgba(6,75,57,.2);transition:transform .2s,box-shadow .2s,filter .2s;cursor:pointer}.btn-login:hover,.btn-login:focus{color:#fff;filter:brightness(1.07);transform:translateY(-1px);box-shadow:0 13px 24px rgba(6,75,57,.25)}.btn-login:disabled{opacity:.75;cursor:wait;transform:none}
.login-alert{display:flex;align-items:flex-start;gap:10px;margin-bottom:19px;padding:13px 14px;border-radius:10px;font-size:.76rem;line-height:1.6}.login-alert i{margin-top:3px}.login-alert-danger{background:#fff4f3;border:1px solid #f4c7c3;color:#9c2e2e}.login-alert-success{background:var(--green-100);border:1px solid var(--border);color:var(--green-900)}
.secure-access{display:flex;align-items:center;justify-content:center;gap:7px;margin-top:23px;color:#849c8e;font-size:.68rem;text-align:center}.secure-access i{color:var(--green-700)}
@media(max-width:991px){.login-hero{display:none}.login-form-wrapper{flex:1;padding:26px}}@media(max-width:576px){.login-form-wrapper{padding:17px}.login-card{padding:31px 24px 27px;border-radius:15px}.login-card h2{font-size:1.45rem}}
@media(prefers-reduced-motion:reduce){*,*:before,*:after{transition:none!important;animation:none!important}}

/* ELIS premium interface refinements */
.login-hero{background:linear-gradient(125deg,rgba(2,46,33,.97) 0%,rgba(4,79,54,.93) 52%,rgba(9,119,79,.84) 100%),url('assets/login/img/land-bg.jpg') center/cover no-repeat}
.login-hero .hero-content{animation:heroEnter .7s ease both}
.hero-feature{transition:transform .2s ease,background .2s ease,border-color .2s ease}
.hero-feature:hover{transform:translateY(-3px);background:rgba(255,255,255,.15);border-color:rgba(255,255,255,.32)}
.hero-brand-line{display:flex;align-items:center;gap:11px;margin-bottom:20px;color:#d7f8e6;font-size:.77rem;font-weight:600;letter-spacing:.06em}
.hero-brand-line:before{content:'';display:block;width:36px;height:2px;background:var(--gold)}
.hero-subtitle{margin-top:15px;font-family:Poppins,sans-serif;font-size:1.08rem;font-weight:600;color:#fff}
.hero-highlights{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:10px;margin-top:35px}
.hero-highlight{padding:17px 13px;background:rgba(255,255,255,.065);border:1px solid rgba(255,255,255,.13);border-radius:13px;backdrop-filter:blur(5px)}
.hero-highlight i{display:block;color:#b5f4cb;font-size:1.1rem;margin-bottom:9px}.hero-highlight strong{display:block;color:#fff;font-size:.78rem}.hero-highlight small{display:block;color:#d4eadf;font-size:.65rem;margin-top:5px;line-height:1.5}
.login-form-wrapper{background:radial-gradient(circle at 85% 6%,rgba(10,149,99,.17),transparent 33%),radial-gradient(circle at 12% 90%,rgba(7,116,78,.10),transparent 33%),linear-gradient(140deg,#eefaf2,#fff 53%,#e7f7ee)}
.login-card{max-width:468px;padding:42px 43px 35px;box-shadow:0 26px 70px rgba(3,60,45,.13),0 5px 20px rgba(3,60,45,.045);animation:cardEnter .6s ease both}
.login-card-brand{padding-bottom:23px;border-bottom:1px solid #e8f1eb;margin-bottom:26px}
.login-card-brand-title{font-size:1.02rem}.login-card-brand-subtitle{font-size:.7rem}
.login-card h2{font-size:1.9rem;letter-spacing:-.025em}
.login-card>.text-muted{font-size:.85rem;margin-bottom:27px}
.form-label{font-size:.8rem}.login-input .form-control{height:53px;font-size:.86rem}
.password-toggle:focus-visible,.forgot-link:focus-visible,.btn-login:focus-visible{outline:3px solid rgba(11,144,102,.35);outline-offset:3px}
.btn-login{min-height:54px;font-size:.9rem;position:relative;overflow:hidden}
.btn-login:before{content:'';position:absolute;inset:0;transform:translateX(-110%);background:linear-gradient(90deg,transparent,rgba(255,255,255,.15),transparent);transition:transform .6s ease}.btn-login:hover:before{transform:translateX(110%)}
.login-help{margin-top:23px;padding-top:20px;border-top:1px solid #e8f1eb;text-align:center;color:#789387;font-size:.74rem;line-height:1.6}
.login-help strong{color:#3d6652}
.mobile-brand{display:none;align-items:center;justify-content:center;gap:9px;margin-bottom:24px;color:var(--green-900);font-family:Poppins,sans-serif;font-size:.84rem;font-weight:700}
.mobile-brand i{display:grid;place-items:center;width:36px;height:36px;border-radius:10px;background:var(--green-900);color:white}
.system-status{display:inline-flex;align-items:center;gap:7px;margin-left:auto;padding:7px 10px;border-radius:999px;background:#eaf8f0;color:#23734d;font-size:.67rem;font-weight:600}
.system-status:before{content:'';width:7px;height:7px;border-radius:50%;background:#28a65a;box-shadow:0 0 0 3px rgba(40,166,90,.12)}
@keyframes cardEnter{from{opacity:0;transform:translateY(15px)}to{opacity:1;transform:translateY(0)}}
@keyframes heroEnter{from{opacity:0;transform:translateX(-14px)}to{opacity:1;transform:translateX(0)}}
@media(max-width:1150px){.login-hero{padding:3rem 2.8rem}.hero-footer{left:2.8rem}.hero-highlights{grid-template-columns:1fr 1fr}.hero-highlight:last-child{display:none}.login-form-wrapper{padding:25px}.login-card{padding:35px 30px}}
@media(max-width:991px){.mobile-brand{display:flex}.login-form-wrapper{padding:36px 20px}.login-card{max-width:470px}}
@media(max-width:576px){.login-card{padding:30px 22px 25px}.login-card h2{font-size:1.55rem}.system-status{font-size:.6rem}.login-card-brand{gap:9px}}
@media(prefers-reduced-motion:reduce){.login-card,.login-hero .hero-content{animation:none!important}}


/* ELIS visual refresh v3 — deliberately distinct split-screen treatment */
body{background:#e8f2eb}
.login-wrapper{background:#e8f2eb}
.login-hero{flex:1.1;padding:70px clamp(45px,6vw,100px);background:radial-gradient(circle at 88% 20%,rgba(40,196,118,.26),transparent 37%),linear-gradient(135deg,#052e24 0%,#064d35 52%,#087a4d 100%);}
.login-hero::before{height:8px;background:linear-gradient(90deg,#f1c44e,#f8e8a1 45%,#d5a72e)}
.login-hero::after{width:750px;height:750px;right:-470px;top:10%;border:1px solid rgba(255,255,255,.15);box-shadow:0 0 0 80px rgba(255,255,255,.025),0 0 0 165px rgba(255,255,255,.02)}
.hero-content{max-width:650px}
.brand-icon{width:75px;height:75px;border-radius:22px;background:rgba(255,255,255,.12);font-size:2rem}
.hero-brand-line{display:inline-block;padding:9px 14px;border:1px solid rgba(243,209,103,.5);background:rgba(243,209,103,.10);border-radius:7px;color:#ffe49a;letter-spacing:.11em;font-size:.67rem;margin-bottom:25px}
.hero-eyebrow{font-size:.8rem;color:#c6ead7;letter-spacing:.08em}
.hero-monogram{font-family:Poppins,sans-serif;font-size:clamp(6rem,11vw,10rem);font-weight:800;line-height:1;letter-spacing:-.09em;color:#fff;text-shadow:0 12px 40px rgba(0,0,0,.15);margin:8px 0 12px}
.monogram-dot{color:#f2c94c}
.login-hero h1{font-size:clamp(1.75rem,2.65vw,2.8rem);font-weight:600;line-height:1.25;letter-spacing:-.03em}
.login-hero h1 span{color:#9df0bc}
.hero-description{font-size:1rem;max-width:530px;line-height:1.9;margin-top:23px}
.hero-highlights{margin-top:35px;gap:12px}
.hero-highlight{background:rgba(255,255,255,.085);border:1px solid rgba(255,255,255,.14);border-radius:16px;backdrop-filter:blur(7px)}
.hero-feature{border-color:rgba(255,255,255,.18);background:rgba(255,255,255,.07)}
.security-notice{border-radius:14px;background:rgba(2,27,18,.35);border-color:rgba(243,209,103,.26)}
.login-form-wrapper{flex:.9;background:radial-gradient(circle at 85% 12%,rgba(9,130,77,.15),transparent 33%),radial-gradient(circle at 15% 95%,rgba(9,130,77,.10),transparent 38%),#f0f8f2;padding:45px}
.login-card{max-width:490px;padding:0 43px 38px;border:1px solid #cfe7d6;border-radius:24px;background:#fff;box-shadow:0 32px 80px rgba(5,63,40,.16),0 8px 24px rgba(5,63,40,.06)}
.login-card::before{display:none}
.login-card-green-band{display:flex;align-items:center;gap:12px;margin:0 -43px 31px;padding:20px 35px;background:linear-gradient(110deg,#07563a,#0c9160);color:#fff;font-size:.79rem;font-weight:750;letter-spacing:.07em;border-radius:23px 23px 0 0}
.login-card-green-band i{color:#f4d778;font-size:1.2rem}
.login-card-green-band small{color:#d0f4e1;font-weight:500}
.login-card-brand{margin-bottom:24px}
.signin-eyebrow{font-size:.68rem;font-weight:750;letter-spacing:.15em;color:#0b8154;margin-bottom:10px;display:flex;align-items:center;gap:8px}
.signin-dot{display:inline-block;width:9px;height:9px;background:#18a66b;border-radius:50%;box-shadow:0 0 0 4px #e3f6ea}
.login-card h2{font-size:2.1rem;letter-spacing:-.04em}
.heading-period{color:#0b9360}
.login-card>.text-muted{font-size:.87rem;margin-bottom:29px}
.form-control{height:53px;border-radius:12px;background:#f9fcfa;border:1px solid #cfdfd5;font-size:.87rem}
.form-label{font-size:.8rem}
.btn-login{height:55px;border-radius:12px;font-size:.9rem;background:linear-gradient(100deg,#065b3d,#0a9861);box-shadow:0 12px 25px rgba(8,128,80,.24)}
.btn-login:hover{background:linear-gradient(100deg,#044c32,#087c50)}
.secure-access{margin-top:27px}
@media(max-width:1150px){.hero-monogram{font-size:6rem}.hero-highlights{grid-template-columns:1fr 1fr}.login-card{padding:0 29px 30px}.login-card-green-band{margin:0 -29px 27px;padding:18px 27px}}
@media(max-width:991px){.login-hero{display:none}.login-form-wrapper{padding:30px 18px}.login-card{max-width:490px}}
@media(max-width:576px){.login-card{padding:0 23px 28px;border-radius:18px}.login-card-green-band{margin:0 -23px 26px;border-radius:17px 17px 0 0;padding:18px 20px;font-size:.66rem}.login-card-green-band small{font-size:.59rem}.login-card h2{font-size:1.7rem}}

</style>
</head>
<body>
<div class="login-wrapper">
<section class="login-hero" aria-label="ELIS introduction">
<div class="hero-content">
<div class="brand-icon"><i class="fas fa-map-marked-alt"></i></div>
<div class="hero-brand-line">OFFICIAL LANDS COMMISSION PLATFORM</div>
<div class="hero-eyebrow">Enterprise Land Information System</div>
<div class="hero-monogram">ELIS<span class="monogram-dot">.</span></div><h1>Digital Land<br><span>Administration</span></h1>
<p class="hero-description">Welcome to the <strong>Enterprise Land Information System (ELIS)</strong>. Securely manage land records, application workflows and spatial information through a unified digital platform.</p>
<div class="hero-highlights">
<div class="hero-highlight"><i class="fas fa-layer-group"></i><strong>Land Records</strong><small>Centralized records and application management</small></div>
<div class="hero-highlight"><i class="fas fa-map-marked-alt"></i><strong>Spatial Services</strong><small>Integrated geospatial information</small></div>
<div class="hero-highlight"><i class="fas fa-tasks"></i><strong>Digital Processes</strong><small>Connected workflows and case tracking</small></div>
</div>
<div class="hero-features">
<div class="hero-feature"><i class="fas fa-shield-alt"></i> Secure Access</div>
<div class="hero-feature"><i class="fas fa-map"></i> Spatial Data</div>
<div class="hero-feature"><i class="fas fa-project-diagram"></i> Digital Workflows</div>
</div>
<div class="security-notice"><i class="fas fa-lock"></i><div><strong>Security Notice</strong><br>Never share your ELIS username, password or verification code with anyone.</div></div>
</div>
<div class="hero-footer">&copy; Lands Commission <span id="footerYear"></span> &nbsp;&bull;&nbsp; Enterprise Land Information System</div>
</section>
<section class="login-form-wrapper" aria-label="ELIS sign in">
<div class="login-card"><div class="login-card-green-band"><i class="fas fa-shield-alt"></i><span>LANDS COMMISSION <small> / OFFICIAL STAFF PORTAL</small></span></div>
<div class="mobile-brand"><i class="fas fa-landmark"></i> LANDS COMMISSION · ELIS</div>
<div class="login-card-brand"><div class="login-card-brand-icon"><i class="fas fa-landmark"></i></div><div><p class="login-card-brand-title">ELIS</p><p class="login-card-brand-subtitle">Lands Commission</p></div><span class="system-status"><span>Secure Portal</span></span></div>
<div class="signin-eyebrow"><span class="signin-dot"></span> STAFF AUTHENTICATION</div><h2>Sign in to ELIS<span class="heading-period">.</span></h2>
<p class="text-muted">Sign in using your official ELIS credentials to continue.</p>
<c:if test="${login eq 'failed'}"><div class="login-alert login-alert-danger" role="alert"><i class="fas fa-exclamation-circle"></i><div><strong>Authentication Failed</strong><br>Please check your username or password and try again.</div></div></c:if>
<c:if test="${login eq 'failed_session'}"><div class="login-alert login-alert-danger" role="alert"><i class="fas fa-clock"></i><div><strong>Session Expired</strong><br>Please sign in again to continue.</div></div></c:if>
<c:if test="${password_changed eq 'passed'}"><div class="login-alert login-alert-success" role="status"><i class="fas fa-check-circle"></i><div><strong>Password Reset Successful</strong><br>You can now sign in using your new password.</div></div></c:if>
<form method="POST" action="two_factor_verification" id="elisLoginForm">
<div class="mb-3"><label for="username" class="form-label">Official Email Address</label><div class="login-input"><i class="fas fa-envelope login-input-icon"></i><input type="email" id="username" name="username" class="form-control" placeholder="Enter your official email" autocomplete="username" required></div></div>
<div class="mb-2"><label for="password" class="form-label">Password</label><div class="login-input password-input"><i class="fas fa-lock login-input-icon"></i><input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" autocomplete="current-password" required><button type="button" class="password-toggle" id="togglePassword" aria-label="Show password" aria-pressed="false"><i class="fas fa-eye"></i></button></div></div>
<div class="mb-4 text-right text-end"><a href="forgot_password" class="forgot-link">Forgot password?</a></div>
<button type="submit" class="btn btn-login" id="loginButton"><span>Sign In</span><i class="fas fa-arrow-right"></i></button>
</form>
<div class="secure-access"><i class="fas fa-shield-alt"></i> Secure access to the Enterprise Land Information System</div>
<div class="login-help">For authorized Lands Commission personnel only.<br><strong>Keep your credentials confidential.</strong></div>
</div>
</section>
</div>
<script src="assets/login/js/jquery-3.5.0.min.js"></script>
<script src="assets/login/js/bootstrap.min.js"></script>
<script>
$(function(){
$('#footerYear').text(new Date().getFullYear());
setTimeout(function(){$('.login-alert').fadeOut(800);},8000);
$('#togglePassword').on('click',function(){var input=$('#password'),icon=$(this).find('i'),show=input.attr('type')==='password';input.attr('type',show?'text':'password');icon.toggleClass('fa-eye',!show).toggleClass('fa-eye-slash',show);$(this).attr('aria-label',show?'Hide password':'Show password').attr('aria-pressed',show?'true':'false');});
$('#elisLoginForm').on('submit',function(){var button=$('#loginButton');button.prop('disabled',true).html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span> Signing In...');});
});
</script>
</body>
</html>
