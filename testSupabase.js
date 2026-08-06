const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://srarnaqyoiqotdntzsyc.supabase.co';
const supabaseKey = 'sb_publishable_evL_EYxXkLL8HBhMuTpS4Q_nqNoALth';
const supabase = createClient(supabaseUrl, supabaseKey);

async function signUp(email, password) {
  const { data, error } = await supabase.auth.signUp({ email, password });
  if (error) {
    console.error('Sign Up Error:', error.message);
  } else {
    console.log('Sign Up Success:', data);
  }
}

async function signIn(email, password) {
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) {
    console.error('Sign In Error:', error.message);
  } else {
    console.log('Sign In Success:', data);
  }
}

// Use provided email and password
(async () => {
  await signUp('it03346543200@gmail.com', 'Password786');
  await signIn('it03346543200@gmail.com', 'Password786');
})();
