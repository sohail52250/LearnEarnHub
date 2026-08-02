require("dotenv").config();

const express = require("express");
const app = express();

const rateLimit=require("./middleware/rate-limit");

app.use(rateLimit);


app.use(express.json());

try {
  app.use("/api/courses", require("./routes/courses"));
app.use("/api/debug-lessons", require("./debug-lessons"));
  console.log("Courses API loaded");
} catch(e) {
  console.log("Courses API error:", e.message);
}

try {
  const unlockCourseRouter = require("./routes/unlock-course");
  app.use("/api/unlock-course", unlockCourseRouter);
  console.log("Unlock Course API loaded");
} catch(e) {
  console.log("Unlock Course API error:", e.message);
}

app.use(express.urlencoded({extended:true}));

app.use(express.static("public"));
const dashboardRoutes = require("./routes/dashboard");
app.use("/api/dashboard", dashboardRoutes);
const certificateRoutes = require("./routes/certificates");
app.use("/api/certificates", certificateRoutes);
const progressRoutes = require("./routes/progress");
app.use("/api/progress", progressRoutes);
app.get("/", (req,res)=>{
  res.sendFile("index.html", { root: "public" });
});


app.get("/api/status",(req,res)=>{
  res.json({
    name:"Learn & Earn Hub",
    status:"Running",
    database:"Supabase"
  });
});

app.use((req,res,next)=>{
  if(req.method==="GET" && req.path.endsWith(".html")){
    res.sendFile(__dirname + "/public" + req.path);
  } else {
    next();
  }
});

try {
  const restoreRouter=require("./routes/restore-center");
  app.use("/api",restoreRouter);
  console.log("Restore Center API loaded");
} catch(e) {
  console.log("Restore Center error",e.message);
}

try {
  const aiDealRouter=require("./routes/ai-deal-room");
  app.use("/api",aiDealRouter);
  console.log("AI Deal API loaded");
} catch(e) {
  console.log("AI Deal API error",e.message);
}

module.exports = app;


// ===== LearnEarnHub Learning APIs =====

const dashboardAPI = require("./api/dashboard");
const certificateAPI = require("./api/certificate");


app.get("/api/dashboard/:user_id", dashboardAPI);

app.post("/api/certificate", certificateAPI);


// ===== End Learning APIs =====



// Lesson Completion API

const completeLessonAPI=require("./api/complete-lesson");

app.post(
"/api/complete-lesson",
completeLessonAPI
);



// Certificate Automation API

const certificateCheck=require("./api/check-certificate");

app.post(
"/api/check-certificate",
certificateCheck
);



// Certificate Verification API

const verifyCertificate=require("./api/verify-certificate");

app.post(
"/api/verify-certificate",
verifyCertificate
);



// User Dashboard API

const userDashboard=require("./api/user-dashboard");

app.get(
"/api/user-dashboard",
userDashboard
);



// Auth User Sync API

const syncUser=require("./api/sync-user");

app.post(
"/api/sync-user",
syncUser
);



// Course Progress API

const courseProgress=require("./api/course-progress");

app.post(
"/api/course-progress",
courseProgress
);



// Course Enrollment API

const enrollment=require("./api/enrollment");

app.post(
"/api/enrollment",
enrollment
);



// Lesson Player API

const lesson=require("./api/lesson");

app.get(
"/api/lesson",
lesson
);

app.post(
"/api/lesson",
lesson
);



// Next Lesson API

const nextLesson=require("./api/next-lesson");

app.get(
"/api/next-lesson",
nextLesson
);



// Certificate Download API

const certificateDownload=require("./api/certificate-download");

app.post(
"/api/certificate-download",
certificateDownload
);

app.get(
"/api/certificate-download",
certificateDownload
);



// PDF Certificate API

const pdfCertificate=require("./api/pdf-certificate");

app.post(
"/api/pdf-certificate",
pdfCertificate
);



// Profile API

const profile=require("./api/profile");

app.get(
"/api/profile",
profile
);

app.post(
"/api/profile",
profile
);



// Authentication API

const auth=require("./api/auth");

app.post(
"/api/auth",
auth
);



// Protected API middleware

const authMiddleware=require("./middleware/auth");


app.get(
"/api/protected-dashboard",
authMiddleware,
(req,res)=>{

res.json({

success:true,

message:"Protected dashboard access"

});

});




// Admin API

const admin=require("./api/admin");
const adminAuth=require("./middleware/admin-auth");

app.get(
"/api/admin",
adminAuth,
admin
);



// Admin Course CRUD API

const adminCourse=require("./api/admin-course");

app.post(
"/api/admin-course",
adminCourse
);



// Admin Lesson CRUD API

const adminLesson=require("./api/admin-lesson");

app.post(
"/api/admin-lesson",
adminLesson
);

app.get(
"/api/admin-lesson",
adminLesson
);



// Admin User Management API

const adminUsers=require("./api/admin-users");

app.get(
"/api/admin-users",
adminUsers
);

app.post(
"/api/admin-users",
adminUsers
);



// Analytics API

const analytics=require("./api/analytics");

app.get(
"/api/analytics",
analytics
);



// Skill Unlock API

const skillUnlock=require("./api/skill-unlock");

app.get(
"/api/skill-unlock",
skillUnlock
);

app.post(
"/api/skill-unlock",
skillUnlock
);



// Certificate Completion Trigger

const certificateComplete=require("./api/certificate-complete");


app.post(
"/api/certificate-complete",
certificateComplete
);




// Skill Marketplace API

const marketplaceJobs=require("./api/marketplace-jobs");


app.get(
"/api/marketplace-jobs",
marketplaceJobs
);


app.post(
"/api/marketplace-jobs",
marketplaceJobs
);




// Employer Marketplace API

const employer=require("./api/employer");


app.get(
"/api/employer",
employer
);


app.post(
"/api/employer",
employer
);




// Earnings API

const earnings=require("./api/earnings");


app.get(
"/api/earnings",
earnings
);


app.post(
"/api/earnings",
earnings
);




// Job Approval API

const jobApproval=require("./api/job-approval");


app.post(
"/api/job-approval",
jobApproval
);




// Automatic Earning Release API

const releaseEarning=require("./api/release-earning");


app.post(
"/api/release-earning",
releaseEarning
);




// Learner Ranking API

const ranking=require("./api/ranking");


app.get(
"/api/ranking",
ranking
);


app.post(
"/api/ranking",
ranking
);




// Notifications API

const notifications=require("./api/notifications");


app.get(
"/api/notifications",
notifications
);


app.post(
"/api/notifications",
notifications
);




// Admin Dashboard API

const adminDashboard=require("./api/admin-dashboard");


app.get(
"/api/admin-dashboard",
adminDashboard
);




// Global Opportunity Engine API

const globalOpportunities=require("./api/opportunities/global");


app.get(
"/api/global-opportunities",
globalOpportunities
);


app.post(
"/api/global-opportunities",
globalOpportunities
);




// Skill Matching API

const skillMatches=require("./api/matching/skills");


app.get(
"/api/skill-matches",
skillMatches
);


app.post(
"/api/skill-matches",
skillMatches
);




// Smart Recommendation API

const recommendations=
require("./api/recommendations");


app.get(
"/api/recommendations",
recommendations
);


app.post(
"/api/recommendations",
recommendations
);




// Employer Candidate Search API

const employerCandidates=
require("./api/employers/candidates");


app.get(
"/api/employer-candidates",
employerCandidates
);


app.post(
"/api/employer-candidates",
employerCandidates
);




// Messaging API

const messages=require("./api/messages");


app.get(
"/api/messages",
messages
);


app.post(
"/api/messages",
messages
);




// Trust Reputation API

const trust=require("./api/trust");


app.post(
"/api/trust",
trust
);




// Admin Verification Console API

const adminVerification=
require("./api/admin-verification");


app.get(
"/api/admin-verification",
adminVerification
);


app.post(
"/api/admin-verification",
adminVerification
);




// Fraud Protection API

const fraudCheck=
require("./api/fraud");


app.post(
"/api/fraud-check",
fraudCheck
);




// Professional Job Import API

const jobImport=require("./api/jobs/import");


app.post(
"/api/jobs/import",
jobImport
);




// Employer Job Posting API

const employerPosts=
require("./api/employer-posts");


app.get(
"/api/employer-posts",
employerPosts
);


app.post(
"/api/employer-posts",
employerPosts
);


