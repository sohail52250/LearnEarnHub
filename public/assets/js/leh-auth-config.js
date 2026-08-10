/*
 * LearnEarnHub authentication configuration.
 *
 * IMPORTANT:
 * Never place Google OAuth client secrets in this file.
 * Production secrets must be configured through Vercel/project
 * environment variables or another secure server-side secret store.
 */

window.LEH_AUTH_CONFIG = Object.freeze({
  provider: "google",
  enabled: true,
  signInPath: "/auth/sign-in.html",
  createAccountPath: "/auth/create-account.html",
  forgotPasswordPath: "/auth/forgot-password.html",
  dashboardPath: "/dashboard/"
});
