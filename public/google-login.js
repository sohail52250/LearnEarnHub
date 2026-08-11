(function(){
  async function getClient(){
    if(window.supabaseClient && window.supabaseClient.auth) return window.supabaseClient;
    if(!window.supabase && !window.supabaseJsLoaded){
      await new Promise(function(resolve,reject){
        var s=document.createElement('script');
        s.src='https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2';
        s.onload=resolve;
        s.onerror=reject;
        document.head.appendChild(s);
      });
    }
    if(!window.SUPABASE_URL || !window.SUPABASE_ANON_KEY){
      await new Promise(function(resolve,reject){
        var s=document.createElement('script');
        s.src='/js/supabase-config.js';
        s.onload=resolve;
        s.onerror=reject;
        document.head.appendChild(s);
      });
    }
    if(!window.supabaseClient){
      if(!window.supabase || !window.SUPABASE_URL || !window.SUPABASE_ANON_KEY) throw new Error('Supabase configuration is unavailable.');
      window.supabaseClient=window.supabase.createClient(window.SUPABASE_URL,window.SUPABASE_ANON_KEY);
    }
    return window.supabaseClient;
  }
  window.googleLogin=async function(){
    var btn=document.getElementById('googleSignInBtn');
    if(btn){btn.disabled=true;btn.classList.add('loading');}
    try{
      var client=await getClient();
      var redirectTo=window.location.origin+'/dashboard-router.html';
      var result=await client.auth.signInWithOAuth({
        provider:'google',
        options:{redirectTo:redirectTo}
      });
      if(result.error) throw result.error;
    }catch(e){
      console.error('Google OAuth:',e);
      alert('Google Sign-In could not start. '+(e.message||'Please try again.'));
      if(btn){btn.disabled=false;btn.classList.remove('loading');}
    }
  };
})();