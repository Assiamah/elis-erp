<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
:root{--otp-forest:#06472f;--otp-dark:#07583d;--otp-green:#087e58;--otp-bright:#0ca678;--otp-mint:#eaf8f1;--otp-border:#cce9da;--otp-gold:#eac56b}
.verification-container{min-height:100vh;position:relative;isolation:isolate;overflow:hidden;display:flex;align-items:center;justify-content:center;padding:48px 18px;background:radial-gradient(circle at 12% 20%,rgba(12,166,120,.13),transparent 28%),radial-gradient(circle at 90% 90%,rgba(6,71,47,.14),transparent 30%),linear-gradient(135deg,#e9f7ef,#f8fcf9 50%,#e4f3eb)}
.verification-container:before,.verification-container:after{content:"";position:absolute;z-index:-1;border-radius:50%;pointer-events:none}
.verification-container:before{width:520px;height:520px;border:75px solid rgba(8,126,88,.055);left:-280px;top:-240px}
.verification-container:after{width:440px;height:440px;border:65px solid rgba(8,126,88,.05);right:-260px;bottom:-260px}
.verification-card{width:100%;max-width:540px;overflow:hidden;background:#fff;border:1px solid var(--otp-border);border-radius:22px;box-shadow:0 28px 75px rgba(6,71,47,.15),0 6px 20px rgba(6,71,47,.05);animation:otpRise .45s ease-out both}
@keyframes otpRise{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:translateY(0)}}
.verification-header{position:relative;text-align:center;padding:34px 28px 32px;color:white;background:linear-gradient(120deg,var(--otp-forest),var(--otp-dark) 55%,var(--otp-green))}
.verification-header:before{content:"";position:absolute;inset:0;opacity:.22;background-image:radial-gradient(rgba(255,255,255,.4) 1px,transparent 1px);background-size:22px 22px;pointer-events:none}
.verification-header:after{content:"";position:absolute;bottom:0;left:0;width:100%;height:4px;background:linear-gradient(90deg,var(--otp-green),#39c58e,var(--otp-gold))}
.verification-header>*{position:relative;z-index:1}
.verification-logo{width:66px;height:66px;display:flex;align-items:center;justify-content:center;margin:0 auto 14px;background:rgba(255,255,255,.13);border:1px solid rgba(255,255,255,.27);border-radius:19px;box-shadow:0 8px 20px rgba(0,0,0,.12);font-size:31px}
.verification-header h1{font-weight:750;font-size:1.55rem;letter-spacing:-.03em;color:#fff;margin:0 0 7px}
.verification-header p{font-size:.84rem;color:rgba(255,255,255,.83);margin:0}
.verification-body{padding:30px 36px 28px}
.verification-intro{text-align:center;margin-bottom:24px}.verification-intro h2{font-size:1.1rem;font-weight:750;color:#173b2b;margin-bottom:7px}.verification-intro p{font-size:.82rem;color:#667b70;margin:0;line-height:1.6}
.contact-info{background:linear-gradient(140deg,#f3fbf6,#eaf8f1);border:1px solid var(--otp-border);border-radius:15px;padding:18px 19px;margin-bottom:21px}
.contact-info h6{color:var(--otp-dark)!important;font-size:.84rem;margin-bottom:15px!important}
.contact-item{display:flex;align-items:center;gap:12px;margin-bottom:13px}.contact-item:last-child{margin-bottom:0}.contact-icon{flex:none;width:39px;height:39px;display:flex;align-items:center;justify-content:center;color:var(--otp-green);background:white;border:1px solid var(--otp-border);border-radius:11px;font-size:1.1rem}
.contact-item .fs-12{color:#6b8275!important}.masked-text{color:#244b38;font-weight:650;word-break:break-word;font-size:.83rem}
.verification-status{display:flex;align-items:center;justify-content:space-between;gap:10px;margin:0 0 19px}.secure-pill{display:inline-flex;align-items:center;gap:7px;background:#e9f8f0;color:#08744f;border:1px solid #c9e9d7;border-radius:30px;padding:8px 12px;font-size:.74rem;font-weight:700}
.timer-display{min-width:96px;text-align:center;padding:8px 13px;border-radius:30px;background:#f2faf5;border:1px solid var(--otp-border);color:var(--otp-green);font-weight:800;font-variant-numeric:tabular-nums;letter-spacing:.05em}.timer-display.expired{background:#fff1f1;color:#ba3434;border-color:#f3c8c8}
.security-note{display:flex;gap:11px;align-items:flex-start;background:#fff9e9;border:1px solid #f4e4b7;border-left:4px solid var(--otp-gold);border-radius:11px;padding:12px 14px;margin-bottom:23px;color:#795d23;font-size:.77rem;line-height:1.55}.security-note i{font-size:1.15rem;margin-top:2px}.security-note strong{display:block;margin-bottom:2px}
.otp-field-label{display:block;text-align:center;color:#244b38;font-size:.83rem;font-weight:700;margin-bottom:13px}
.otp-input-group{display:flex;justify-content:center;gap:9px;margin-bottom:22px}.otp-input-group .otp-input{width:54px!important;min-width:0;height:62px!important;padding:0!important;text-align:center;font-size:1.55rem;font-weight:800;color:var(--otp-dark);background:#fbfefc;border:1.5px solid #c9dfd1;border-radius:12px;box-shadow:0 3px 8px rgba(6,71,47,.04);transition:border-color .2s,box-shadow .2s,transform .2s}
.otp-input-group .otp-input:focus{border-color:var(--otp-bright);background:white;box-shadow:0 0 0 4px rgba(12,166,120,.14)!important;outline:none;transform:translateY(-2px)}.otp-input-group .otp-input.filled{border-color:var(--otp-green);background:var(--otp-mint)}
.resend-area{text-align:center;margin-bottom:22px}.resend-area p{font-size:.8rem;color:#718278;margin-bottom:5px}.resend-link{display:inline-flex;align-items:center;gap:6px;color:var(--otp-green);font-size:.82rem;font-weight:750;text-decoration:none}.resend-link:hover{color:var(--otp-forest);text-decoration:underline}
#btn-verify{width:100%;min-height:52px;border:0;border-radius:12px;color:white;font-size:.9rem;font-weight:750;letter-spacing:.01em;background:linear-gradient(105deg,var(--otp-forest),var(--otp-green),var(--otp-bright));box-shadow:0 9px 22px rgba(8,126,88,.25);transition:transform .2s,box-shadow .2s,filter .2s}#btn-verify:hover:not(:disabled){transform:translateY(-2px);filter:brightness(1.06);box-shadow:0 12px 26px rgba(8,126,88,.32)}#btn-verify:disabled{opacity:.7;cursor:wait}
.back-section{border-top:1px solid #e4eee7;margin-top:23px;padding-top:19px;text-align:center}.back-link{display:inline-flex;align-items:center;gap:7px;color:#637a6e;font-size:.81rem;font-weight:650;text-decoration:none}.back-link:hover{color:var(--otp-green)}
.verification-footer{text-align:center;font-size:.68rem;color:#8a9b91;margin-top:19px}
@media(max-width:575px){.verification-container{padding:16px 11px}.verification-card{border-radius:17px}.verification-header{padding:28px 18px 25px}.verification-header h1{font-size:1.3rem}.verification-body{padding:24px 18px}.otp-input-group{gap:6px}.otp-input-group .otp-input{width:calc((100% - 30px)/6)!important;height:53px!important;font-size:1.25rem;border-radius:9px}.verification-status{flex-wrap:wrap}.security-note{font-size:.72rem}}
@media(prefers-reduced-motion:reduce){.verification-card{animation:none}.otp-input-group .otp-input,#btn-verify{transition:none}}
.otp-preview{display:flex;align-items:center;justify-content:space-between;gap:12px;background:linear-gradient(120deg,#e7f8ee,#f4fcf7);border:1px dashed #24a875;border-radius:14px;padding:14px 18px;margin:0 0 20px}.otp-preview-label{color:#086443;font-weight:700;font-size:.84rem}.otp-preview-code{color:#086443;font-size:1.6rem;letter-spacing:.14em;overflow-wrap:anywhere}@media(max-width:480px){.otp-preview{flex-direction:column;align-items:flex-start}}

/* Full-screen, no-page-scroll verification layout */
html:has(.verification-container),body:has(.verification-container){height:100%;overflow:hidden!important}
.verification-container{position:fixed!important;inset:0!important;width:100%;height:100dvh!important;min-height:0!important;padding:12px!important;overflow:hidden!important;box-sizing:border-box}
.verification-card{flex:0 0 auto;max-width:min(540px,100%);transform-origin:center center;animation:none!important}
@media(max-height:850px){.verification-header{padding:18px 24px 16px}.verification-logo{width:42px;height:42px;margin-bottom:7px;font-size:22px}.verification-body{padding:17px 27px 16px}.verification-intro{margin-bottom:10px}.verification-intro h2{margin-bottom:3px}.otp-preview{padding:8px 13px;margin-bottom:10px}.otp-preview-code{font-size:1.3rem}.contact-info{padding:10px 13px;margin-bottom:10px}.contact-info h6{margin-bottom:7px!important}.contact-item{margin-bottom:5px}.contact-icon{width:30px;height:30px}.verification-status{margin-bottom:10px}.security-note{padding:8px 10px;margin-bottom:10px}.otp-field-label{margin-bottom:6px}.otp-input-group{margin-bottom:11px}.otp-input-group .otp-input{height:47px!important}.resend-area{margin-bottom:11px}#btn-verify{min-height:44px}.back-section{margin-top:11px;padding-top:10px}.verification-footer{margin-top:8px}}
@media(max-width:575px){.verification-container{padding:8px!important}.verification-body{padding:14px 15px}.verification-header{padding:14px 12px}.verification-header h1{font-size:1.18rem}.verification-header p{font-size:.73rem}.contact-info{padding:9px 10px}.otp-input-group{gap:5px}.otp-input-group .otp-input{height:45px!important}.security-note{font-size:.7rem}}
</style>

<div class="verification-container">
  <div class="verification-card">
    <div class="verification-header">
      <div class="verification-logo"><i class="ri-shield-check-line"></i></div>
      <h1>Two-Factor Verification</h1>
      <p>Enterprise Land Information System &bull; Secure Sign In</p>
    </div>
    <div class="verification-body">
      <div class="verification-intro">
        <h2>Verify Your Identity</h2>
        <p>Enter the six-digit verification code sent to your registered contact details.</p>
      </div>
      <div class="otp-preview"><span class="otp-preview-label"><i class="ri-key-2-line me-1"></i> OTP Code</span><strong class="otp-preview-code"><c:out value="${otp_code}" /></strong></div>
      <div class="contact-info">
        <h6 class="fw-semibold"><i class="ri-send-plane-line me-2"></i>Verification code sent to</h6>
        <div class="contact-item"><div class="contact-icon"><i class="ri-smartphone-line"></i></div><div><div class="fs-12">Registered mobile number</div><div class="masked-text" id="phone_number"><c:out value="${user_phone}" /></div></div></div>
        <div class="contact-item"><div class="contact-icon"><i class="ri-mail-line"></i></div><div><div class="fs-12">Registered email address</div><div class="masked-text" id="user_emailaddress"></div></div></div>
      </div>
      <div class="verification-status"><span class="secure-pill"><i class="ri-shield-check-line"></i> Secure Verification</span><span id="timer" class="timer-display" role="timer" aria-live="off">10:00</span></div>
      <div class="security-note"><i class="ri-alert-line"></i><div><strong>Security reminder</strong>Never share your verification code with anyone. The code is valid for 10 minutes.</div></div>
      <form name="loginForm" id="loginForm" method="POST" action="Login" novalidate>
        <label class="otp-field-label" for="vc_1">Enter your 6-digit verification code</label>
        <div class="otp-input-group" aria-label="Six digit verification code">
          <input type="text" inputmode="numeric" autocomplete="one-time-code" pattern="[0-9]*" class="form-control otp-input" id="vc_1" name="vc_1" maxlength="1" required autofocus>
          <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_2" name="vc_2" maxlength="1" required>
          <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_3" name="vc_3" maxlength="1" required>
          <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_4" name="vc_4" maxlength="1" required>
          <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_5" name="vc_5" maxlength="1" required>
          <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_6" name="vc_6" maxlength="1" required>
        </div>
        <div class="resend-area"><p>Didn't receive your code?</p><a href="#" id="resendLink" class="resend-link"><i class="ri-refresh-line"></i> Resend Verification Code</a></div>
        <button type="submit" id="btn-verify" class="btn btn-primary"><span class="button-text"><i class="ri-shield-check-line me-2"></i>Verify &amp; Continue</span><span class="loading-text d-none"><span class="spinner-border spinner-border-sm me-2" role="status"></span>Verifying...</span></button>
      </form>
      <div class="back-section"><a href="${pageContext.request.contextPath}/" class="back-link"><i class="ri-arrow-left-line"></i> Return to Login Page</a></div>
      <div class="verification-footer"><i class="ri-lock-2-line me-1"></i> Lands Commission &bull; Enterprise Land Information System</div>
    </div>
  </div>
</div>

<script>
$(function(){
  const inputs=Array.from(document.querySelectorAll('.verification-card .otp-input'));
  const timerEl=document.getElementById('timer');
  const resend=document.getElementById('resendLink');
  const form=document.getElementById('loginForm');
  const verify=document.getElementById('btn-verify');
  const duration=600;
  const timerKey='elisOtpCountdownTarget';
  let intervalId=null;
  // OTP preview is intentionally displayed above to preserve the original JSP behavior.
  const phone=document.getElementById('phone_number');
  if(phone){phone.textContent=phone.textContent.trim().replace(/\d(?=\d{3})/g,'*');}
  const emailValue='<c:out value="${user_emailaddress}" />';
  function maskEmail(value){const parts=value.trim().split('@');if(parts.length!==2)return 'Registered email';const local=parts[0];return (local.length>2?local.slice(0,2):local.slice(0,1))+'***@'+parts[1];}
  document.getElementById('user_emailaddress').textContent=maskEmail(emailValue);
  function setResendEnabled(enabled){resend.style.pointerEvents=enabled?'auto':'none';resend.style.opacity=enabled?'1':'.5';resend.setAttribute('aria-disabled',String(!enabled));}
  function countdown(){const now=Date.now();let target=Number(sessionStorage.getItem(timerKey));if(!target){target=now+duration*1000;sessionStorage.setItem(timerKey,String(target));}const seconds=Math.max(0,Math.ceil((target-now)/1000));timerEl.textContent=seconds?String(Math.floor(seconds/60)).padStart(2,'0')+':'+String(seconds%60).padStart(2,'0'):'Expired';timerEl.classList.toggle('expired',seconds===0);setResendEnabled(seconds===0);if(!seconds&&intervalId){clearInterval(intervalId);intervalId=null;}}
  countdown();intervalId=setInterval(countdown,1000);
  function allDigits(){return inputs.every(x=>/^\d$/.test(x.value));}
  let submitted=false;
  function submitCompletedOtp(){
    if(submitted||!allDigits())return;
    // requestSubmit triggers the existing validation and submit handler.
    if(typeof form.requestSubmit==='function')form.requestSubmit(verify);
    else verify.click();
  }
  inputs.forEach((input,index)=>{
    input.addEventListener('input',()=>{const digits=input.value.replace(/\D/g,'');input.value=digits.slice(-1);input.classList.toggle('filled',!!input.value);if(input.value&&index<inputs.length-1)inputs[index+1].focus();if(allDigits())submitCompletedOtp();});
    input.addEventListener('keydown',e=>{if(e.key==='Backspace'&&!input.value&&index>0){inputs[index-1].value='';inputs[index-1].classList.remove('filled');inputs[index-1].focus();}if(e.key==='ArrowLeft'&&index>0)inputs[index-1].focus();if(e.key==='ArrowRight'&&index<inputs.length-1)inputs[index+1].focus();});
    input.addEventListener('paste',e=>{e.preventDefault();const digits=(e.clipboardData.getData('text').match(/\d/g)||[]).slice(0,6);digits.forEach((d,i)=>{inputs[i].value=d;inputs[i].classList.add('filled');});inputs[Math.min(digits.length,5)].focus();if(allDigits())submitCompletedOtp();});
  });
  form.addEventListener('submit',function(e){if(submitted){e.preventDefault();return;}if(!allDigits()){e.preventDefault();inputs.find(x=>!/^\d$/.test(x.value))?.focus();return;}submitted=true;verify.disabled=true;verify.querySelector('.button-text').classList.add('d-none');verify.querySelector('.loading-text').classList.remove('d-none');});
  resend.addEventListener('click',function(e){e.preventDefault();if(resend.getAttribute('aria-disabled')==='true')return;
    // Resend requires a dedicated server endpoint tied to the authenticated pending-login session.
    // Do not send the original password back to the browser or resubmit it in a hidden form.
    const endpoint=resend.dataset.endpoint;
    if(!endpoint){alert('Please return to the login page to request a new verification code.');return;}
    setResendEnabled(false);fetch(endpoint,{method:'POST',credentials:'same-origin',headers:{'X-Requested-With':'XMLHttpRequest'}}).then(r=>{if(!r.ok)throw Error('Unable to resend');sessionStorage.setItem(timerKey,String(Date.now()+duration*1000));timerEl.classList.remove('expired');countdown();if(!intervalId)intervalId=setInterval(countdown,1000);inputs.forEach(x=>{x.value='';x.classList.remove('filled');});inputs[0].focus();}).catch(()=>{setResendEnabled(true);alert('Could not resend the code. Please try again or return to login.');});
  });
  inputs[0].focus();
});
</script>

<script>
/* Keep the complete verification card visible without vertical page scrolling,
   including on smaller laptop and mobile screens. */
(function(){
  const card=document.querySelector('.verification-card');
  const container=document.querySelector('.verification-container');
  if(!card||!container)return;
  function fitCard(){
    card.style.transform='none';
    const availableHeight=container.clientHeight-20;
    const availableWidth=container.clientWidth-20;
    const naturalHeight=card.scrollHeight;
    const naturalWidth=card.offsetWidth;
    const scale=Math.min(1,availableHeight/naturalHeight,availableWidth/naturalWidth);
    card.style.transform='scale('+Math.max(0.1,scale).toFixed(4)+')';
  }
  window.addEventListener('resize',fitCard,{passive:true});
  window.addEventListener('orientationchange',fitCard);
  if(document.fonts&&document.fonts.ready)document.fonts.ready.then(fitCard);
  requestAnimationFrame(fitCard);
})();
</script>
