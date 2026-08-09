async function awardReward(userId, xp, units){

  const client = supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY
  );

  const { data: profile } = await client
    .from("profiles")
    .select("xp,reward_units")
    .eq("id", userId)
    .single();

  if(!profile) return;

  await client
    .from("profiles")
    .update({
      xp: (profile.xp || 0) + xp,
      reward_units: (profile.reward_units || 0) + units
    })
    .eq("id", userId);
}

window.awardReward = awardReward;
