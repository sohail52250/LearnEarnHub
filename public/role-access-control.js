/*
 * LearnEarnHub — Central Authentication & Role Access
 *
 * Supabase session is the authentication source of truth.
 * localStorage is only used as a cache/fallback.
 */

(function () {
  "use strict";

  const ROLE_ROUTES = {
    learner: "/learner-dashboard.html",
    seller: "/seller-dashboard.html",
    business: "/business-dashboard.html",
    investor: "/investor-profile.html",
    instructor: "/instructor-dashboard.html",
    admin: "/admin-control-dashboard.html",
    sponsor: "/account-center.html"
  };

  function normalizeRole(role) {
    return role ? String(role).trim().toLowerCase() : "";
  }

  function redirectByRole(role) {
    const normalized = normalizeRole(role);
    const target = ROLE_ROUTES[normalized] || "/account-center.html";

    if (window.location.pathname !== target) {
      window.location.replace(target);
    }
  }

  async function getAuthenticatedUser() {
    try {
      if (
        window.supabase &&
        typeof window.supabase.createClient === "function" &&
        window.SUPABASE_URL &&
        window.SUPABASE_ANON_KEY
      ) {
        const client = window.supabase.createClient(
          window.SUPABASE_URL,
          window.SUPABASE_ANON_KEY
        );

        const { data, error } = await client.auth.getUser();

        if (!error && data && data.user) {
          return {
            authUser: data.user,
            client
          };
        }
      }
    } catch (error) {
      console.warn(
        "Supabase authentication lookup failed:",
        error
      );
    }

    return {
      authUser: null,
      client: null
    };
  }

  async function resolveUserRole(authUser, client) {
    let role = "";

    try {
      role =
        normalizeRole(authUser && authUser.user_metadata && authUser.user_metadata.role) ||
        normalizeRole(authUser && authUser.app_metadata && authUser.app_metadata.role);
    } catch (error) {}

    if (!role) {
      try {
        const stored = localStorage.getItem("user");

        if (stored) {
          const parsed = JSON.parse(stored);

          role =
            normalizeRole(parsed && parsed.role) ||
            normalizeRole(
              parsed &&
              parsed.user_metadata &&
              parsed.user_metadata.role
            ) ||
            normalizeRole(
              parsed &&
              parsed.app_metadata &&
              parsed.app_metadata.role
            );
        }
      } catch (error) {
        console.warn(
          "Invalid stored user object:",
          error
        );

        localStorage.removeItem("user");
      }
    }

    if (!role && client && authUser && authUser.id) {
      try {
        const { data, error } = await client
          .from("user_roles")
          .select("role")
          .eq("user_id", authUser.id)
          .maybeSingle();

        if (!error && data) {
          role = normalizeRole(data.role);
        }
      } catch (error) {
        console.warn(
          "user_roles lookup failed:",
          error
        );
      }
    }

    return role;
  }

  async function getCurrentUser() {
    const result = await getAuthenticatedUser();
    const authUser = result.authUser;
    const client = result.client;

    if (!authUser) {
      try {
        const stored = localStorage.getItem("user");

        if (stored) {
          const parsed = JSON.parse(stored);

          if (parsed && parsed.id) {
            return parsed;
          }
        }
      } catch (error) {}

      window.location.replace("/login.html");
      return null;
    }

    const role = await resolveUserRole(
      authUser,
      client
    );

    const user = {
      ...authUser,
      role: role || "learner"
    };

    try {
      localStorage.setItem(
        "user",
        JSON.stringify(user)
      );

      localStorage.setItem(
        "user_id",
        authUser.id
      );

      if (role) {
        localStorage.setItem(
          "user_role",
          role
        );
      }
    } catch (error) {}

    return user;
  }

  window.redirectByRole = redirectByRole;
  window.getCurrentUser = getCurrentUser;
  window.resolveUserRole = resolveUserRole;
})();
