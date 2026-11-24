<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<style>
:root{--elis-forest:#063e2e;--elis-dark:#07543f;--elis-green:#087b58;--elis-bright:#10a674;--elis-mint:#e9f8f0;--elis-gold:#e9bd57}
.elis-login{min-height:100vh;background:#f1f8f4;font-family:Inter,'Segoe UI',sans-serif}
.elis-login .auth-left-container{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:48px 28px;background:radial-gradient(circle at 0% 0%,#d4f2e0 0,transparent 38%),radial-gradient(circle at 100% 100%,#c5ead8 0,transparent 35%),linear-gradient(145deg,#f5fbf7,#e9f5ee);position:relative;overflow:hidden}
.elis-login .auth-left-container:before{content:"";position:absolute;inset:0;background-image:radial-gradient(#0a855d 1px,transparent 1px);background-size:26px 26px;opacity:.075;pointer-events:none}
.elis-login .auth-card{width:100%;max-width:490px;background:#fff;border:1px solid #c6e8d4;border-radius:23px;box-shadow:0 28px 70px rgba(4,67,42,.14);position:relative;overflow:hidden;z-index:1}
.elis-login .env-card-banner{text-align:center;padding:9px 14px;background:linear-gradient(90deg,#aa5c0a,#e7a13a);color:#fff;font-size:.72rem;font-weight:800;letter-spacing:1.5px;text-transform:uppercase}
.elis-login .auth-card-header{background:linear-gradient(125deg,#063e2e 0%,#087b58 68%,#0eaa73 100%);padding:34px 30px 32px;text-align:center;color:#fff;position:relative;overflow:hidden}
.elis-login .auth-card-header:before{content:"";position:absolute;width:230px;height:230px;border:35px solid rgba(255,255,255,.055);border-radius:50%;right:-95px;top:-120px}
.elis-login .auth-card-header:after{content:"";position:absolute;bottom:0;left:0;right:0;height:4px;background:linear-gradient(90deg,transparent,var(--elis-gold),transparent)}
.elis-login .auth-logo{width:78px;height:78px;border-radius:20px;display:flex;align-items:center;justify-content:center;background:#fff;margin:0 auto 17px;box-shadow:0 10px 25px rgba(0,0,0,.2);position:relative;z-index:1}
.elis-login .auth-logo img{width:55px;height:55px;object-fit:contain;border-radius:50%}
.elis-login .auth-title{font-size:1.35rem;font-weight:800;color:#fff;line-height:1.4;position:relative;z-index:1;margin:0}
.elis-login .auth-subtitle{font-size:.73rem;font-weight:700;color:#bdf4d4;text-transform:uppercase;letter-spacing:2px;margin-top:8px;position:relative;z-index:1}
.elis-login .auth-card-body{padding:35px 40px 36px}
.elis-login .welcome-title{color:var(--elis-dark);font-weight:800;font-size:1.5rem;margin:0 0 6px}
.elis-login .welcome-subtitle{color:#728279;font-size:.85rem}
.elis-login .field-label{font-size:.76rem;color:#235844;font-weight:700;margin-bottom:8px;display:block}
.elis-login .login-field{position:relative}
.elis-login .login-field>.field-icon{position:absolute;top:50%;left:15px;transform:translateY(-50%);color:#719b85;font-size:1.1rem;pointer-events:none}
.elis-login .login-field .form-control{height:53px;border:1px solid #cfe3d6;border-radius:12px;padding:12px 47px;background:#fbfefc;color:#153c2c;font-size:.89rem;transition:.2s;box-shadow:none}
.elis-login .login-field .form-control:hover{border-color:#91c9a9}
.elis-login .login-field .form-control:focus{border-color:var(--elis-green);background:#fff;box-shadow:0 0 0 4px rgba(8,123,88,.12)}
.elis-login .password-toggle{position:absolute;top:50%;right:11px;transform:translateY(-50%);border:0;background:transparent;color:#658b78;padding:8px 10px;cursor:pointer}
.elis-login .form-check-input:checked{background-color:var(--elis-green);border-color:var(--elis-green)}
.elis-login .forgot-link{color:var(--elis-green);font-size:.82rem;font-weight:700;text-decoration:none}
.elis-login .forgot-link:hover{text-decoration:underline;color:var(--elis-dark)}
.elis-login .btn-login{width:100%;height:53px;border:0;border-radius:12px;background:linear-gradient(110deg,#07543f,#0a9669);color:white;font-size:.95rem;font-weight:750;box-shadow:0 9px 22px rgba(8,123,88,.25);transition:transform .2s,box-shadow .2s,filter .2s}
.elis-login .btn-login:hover{color:#fff;filter:brightness(1.08);transform:translateY(-2px);box-shadow:0 14px 25px rgba(8,123,88,.3)}
.elis-login .btn-login:disabled{opacity:.75;transform:none}
.elis-login .secure-note{display:flex;align-items:center;justify-content:center;gap:8px;font-size:.73rem;color:#7b9587;margin-top:22px}
.elis-login .secure-note i{color:var(--elis-green)}
.elis-login .welcome-panel{position:relative;min-height:100vh;overflow:hidden;background:var(--elis-forest);color:white}
.elis-login .welcome-panel>.panel-bg{position:absolute;inset:0;width:100%;height:100%;object-fit:cover}
.elis-login .welcome-panel:before{content:"";position:absolute;inset:0;z-index:1;background:linear-gradient(125deg,rgba(3,43,30,.96),rgba(6,83,57,.89) 60%,rgba(8,119,78,.8))}
.elis-login .welcome-panel:after{content:"";position:absolute;inset:0;z-index:1;background-image:radial-gradient(rgba(255,255,255,.18) 1px,transparent 1px);background-size:26px 26px;opacity:.25}
.elis-login .panel-content{position:relative;z-index:2;min-height:100vh;display:flex;flex-direction:column;justify-content:center;padding:60px clamp(35px,6vw,100px)}
.elis-login .panel-eyebrow{display:inline-block;color:#f2d28b;text-transform:uppercase;letter-spacing:2px;font-size:.73rem;font-weight:800;margin-bottom:19px}
.elis-login .panel-title{font-size:clamp(2.1rem,3.1vw,3.5rem);font-weight:850;line-height:1.15;color:#fff;margin:0 0 20px}
.elis-login .panel-title span{color:#9ff0bc}
.elis-login .panel-description{color:#d7eae0;max-width:620px;font-size:1rem;line-height:1.8}
.elis-login .feature-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:13px;margin-top:38px}
.elis-login .feature-tile{border:1px solid rgba(255,255,255,.19);border-radius:15px;background:rgba(255,255,255,.09);backdrop-filter:blur(12px);padding:21px 15px;transition:transform .2s,background .2s}
.elis-login .feature-tile:hover{transform:translateY(-4px);background:rgba(255,255,255,.15)}
.elis-login .feature-tile i{color:#b7f4cd;font-size:1.65rem;display:block;margin-bottom:12px}
.elis-login .feature-tile h4{font-size:.86rem;font-weight:750;color:#f4d488;margin:0 0 7px}
.elis-login .feature-tile p{font-size:.73rem;line-height:1.6;color:#e0f0e6;margin:0}
.elis-login .panel-footer{margin-top:46px;padding-top:20px;border-top:1px solid rgba(255,255,255,.19);font-size:.78rem;color:#c9e6d4}
.elis-login .alert{border-radius:11px}
@media(max-width:1199px){.elis-login .feature-grid{grid-template-columns:1fr}.elis-login .feature-tile{display:flex;gap:14px;align-items:flex-start}.elis-login .feature-tile i{margin:0}.elis-login .panel-content{padding:45px 35px}}
@media(max-width:991px){.elis-login .auth-left-container{min-height:100vh;padding:30px 18px}}
@media(max-width:575px){.elis-login .auth-card-body{padding:27px 23px}.elis-login .auth-card-header{padding:29px 18px}.elis-login .auth-card{border-radius:17px}}

/* Modern floating-label emerald input controls */
.elis-login .modern-field{margin-top:8px;isolation:isolate}
.elis-login .modern-field .form-control{height:62px;padding:24px 52px 9px 52px;border:1.5px solid #c5dfd0;border-radius:16px;background:linear-gradient(145deg,#fff,#f5fcf8);font-size:.96rem;font-weight:600;letter-spacing:.1px;box-shadow:0 3px 10px rgba(5,84,63,.035);transition:border-color .2s,box-shadow .2s,background .2s}
.elis-login .modern-field .form-control:hover{border-color:#60b78c;background:#fff}
.elis-login .modern-field .form-control:focus{border-color:#07845c;background:#fff;box-shadow:0 0 0 4px rgba(8,123,88,.13),0 8px 20px rgba(5,84,63,.07)}
.elis-login .modern-field>.field-icon{left:18px;z-index:2;font-size:1.22rem;color:#0b8b63}
.elis-login .modern-field .modern-floating-label{position:absolute;z-index:2;left:52px;top:50%;transform:translateY(-50%);color:#6a8274;font-size:.89rem;font-weight:500;pointer-events:none;transition:top .17s,font-size .17s,color .17s,transform .17s}
.elis-login .modern-field .form-control:focus~.modern-floating-label,.elis-login .modern-field .form-control:not(:placeholder-shown)~.modern-floating-label{top:13px;transform:none;font-size:.68rem;font-weight:750;letter-spacing:.35px;color:#087b58}
.elis-login .modern-field .password-toggle{z-index:3;right:12px;display:grid;place-items:center;width:37px;height:37px;border-radius:10px;background:#e9f8f0;color:#087b58;transition:background .2s}
.elis-login .modern-field .password-toggle:hover{background:#d2f0e0}
.elis-login .panel-title{max-width:690px}
@media(max-width:575px){.elis-login .modern-field .form-control{height:59px}}
</style>
<div class="container-fluid p-0 elis-login">
 <div class="row g-0">
  <div class="col-lg-6">
   <div class="auth-left-container">
    <div class="auth-card">
     <div class="env-card-banner">${server_version}</div>
     <div class="auth-card-header">
      <div class="auth-logo"><img src="${pageContext.request.contextPath}/assets/images/NewLogo.jpg" alt="Lands Commission logo"></div>
      <h1 class="auth-title">Enterprise Land Information System</h1>
      <p class="auth-subtitle mb-0">Secure Staff Access</p>
     </div>
     <div class="auth-card-body">
      <div class="text-center mb-4"><h2 class="welcome-title">Welcome Back</h2><p class="welcome-subtitle mb-0">Sign in with your official ELIS credentials</p></div>
      <c:if test="${login == 'failed'}"><div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4" role="alert"><i class="ri-error-warning-line fs-20 me-3"></i><div><strong>Authentication Failed</strong><br><small>Invalid credentials. Please check your email and password.</small></div><button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>
      <c:if test="${login == 'disabled'}"><div class="alert alert-warning alert-dismissible fade show d-flex align-items-center mb-4" role="alert"><i class="ri-user-unfollow-line fs-20 me-3"></i><div><strong>Account Disabled</strong><br><small>Please contact your system administrator for assistance.</small></div><button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>
      <form name="loginForm" id="loginForm" method="POST" action="two_factor_verification" novalidate>
       <div class="mb-3"><div class="login-field modern-field"><i class="ri-mail-line field-icon"></i><input type="email" class="form-control" name="email" id="email" placeholder=" " pattern="[a-zA-Z0-9._%+-]+@lc\.gov\.gh$" title="Email must be a valid @lc.gov.gh address" autocomplete="username" required><label class="modern-floating-label" for="email">Official Email Address</label></div><small class="text-muted"><i class="ri-information-line me-1"></i>Your User ID is your official email address</small></div>
       <div class="mb-3"><div class="login-field modern-field"><i class="ri-lock-line field-icon"></i><input type="password" class="form-control" name="password" id="password" placeholder=" " autocomplete="current-password" required><label class="modern-floating-label" for="password">Password</label><button type="button" class="password-toggle" onclick="togglePassword('password',this)" aria-label="Show or hide password"><i class="ri-eye-off-line"></i></button></div></div>
       <div class="d-flex justify-content-between align-items-center mb-4 gap-2"><div class="form-check"><input class="form-check-input" type="checkbox" id="rememberMe"><label class="form-check-label small" for="rememberMe">Remember this device</label></div><a href="forgot_password" class="forgot-link">Forgot Password?</a></div>
       <button type="submit" id="btn-login" class="btn btn-login"><span class="login-text"><i class="ri-login-circle-line me-2"></i>Sign In Securely</span><span class="loading-text d-none"><span class="spinner-border spinner-border-sm me-2" role="status"></span>Authenticating...</span></button>
      </form>
      <div class="secure-note"><i class="ri-shield-check-line"></i>Authorized Lands Commission personnel only</div>
     </div>
    </div>
   </div>
  </div>
  <div class="col-lg-6 d-none d-lg-block">
   <section class="welcome-panel"><img class="panel-bg" src="${pageContext.request.contextPath}/assets/images/login/login-bg.jpeg" alt="Land information background">
    <div class="panel-content"><div><div class="panel-eyebrow"><i class="ri-government-line me-2"></i>Lands Commission · Ghana</div><h2 class="panel-title">Enterprise Land <span>Information System</span></h2><p class="panel-description">The Enterprise Land Information System connects land records, property information, spatial intelligence and approval workflows in one secure digital platform.</p></div>
     <div class="feature-grid"><div class="feature-tile"><i class="ri-map-pin-line"></i><div><h4>Spatial Data</h4><p>Integrated GIS mapping and spatial analysis.</p></div></div><div class="feature-tile"><i class="ri-database-2-line"></i><div><h4>Land Records</h4><p>Centralized registry and property information.</p></div></div><div class="feature-tile"><i class="ri-shield-check-line"></i><div><h4>Secure Workflows</h4><p>Role-based access and accountable processing.</p></div></div></div>
     <div class="panel-footer"><i class="ri-lock-line me-2"></i>Official Lands Commission System &nbsp;·&nbsp; Version 5.0 &nbsp;·&nbsp; Authorized use only</div>
    </div>
   </section>
  </div>
 </div>
</div>
<script>
$(document).ready(function(){
 console.log('%cSECURITY WARNING','color:#d33;font-size:20px;font-weight:bold');
 console.log('Do not enter credentials or commands into the browser developer console.');
 window.togglePassword=function(inputId,button){const input=document.getElementById(inputId);const icon=button.querySelector('i');const show=input.type==='password';input.type=show?'text':'password';icon.classList.toggle('ri-eye-line',show);icon.classList.toggle('ri-eye-off-line',!show);};
 $('#loginForm').on('submit',function(e){if(!this.checkValidity()){e.preventDefault();this.reportValidity();return;}const btn=$('#btn-login');btn.find('.login-text').addClass('d-none');btn.find('.loading-text').removeClass('d-none');btn.prop('disabled',true);});
 setTimeout(function(){$('.elis-login .alert-dismissible').alert('close');},5000);
 $('.alternate-link').on('click',function(e){e.preventDefault();if(typeof Swal==='undefined')return;Swal.fire({title:'Contact System Administrator',html:'<div class="text-start"><p><strong>IT Support Department</strong><br>Lands Commission Headquarters</p><p><i class="ri-mail-line me-2"></i>itsupport@lc.gov.gh</p><p><i class="ri-phone-line me-2"></i>+233 30 123 4567</p><p><i class="ri-time-line me-2"></i>Monday – Friday, 8:00 AM – 5:00 PM (GMT)</p><p class="small text-muted">Please have your employee ID ready when contacting support.</p></div>',icon:'info',confirmButtonText:'Got it',confirmButtonColor:'#087b58'});});
});
</script>
