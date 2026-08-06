
create index if not exists
ai_course_reviews_score_idx

on ai_course_reviews(overall_score);


create index if not exists
ai_course_reviews_status_idx

on ai_course_reviews(recommendation);


