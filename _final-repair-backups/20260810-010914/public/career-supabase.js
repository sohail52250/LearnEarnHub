const SUPABASE_URL = window.SUPABASE_URL;
const SUPABASE_KEY = window.SUPABASE_KEY;

async function loadLearnerCareer(userId){

  const response = await fetch(
    `${SUPABASE_URL}/rest/v1/learner_profiles?id=eq.${userId}`,
    {
      headers:{
        apikey:SUPABASE_KEY,
        Authorization:`Bearer ${SUPABASE_KEY}`
      }
    }
  );

  const data = await response.json();

  if(!data.length){
    return [];
  }

  return data[0].skills || [];
}


async function generateCareerPath(userId){

  const skills = await loadLearnerCareer(userId);

  if(typeof getRecommendations !== "undefined"){
    return getRecommendations(skills);
  }

  return [];
}


window.generateCareerPath = generateCareerPath;
