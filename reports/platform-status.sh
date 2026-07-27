echo "===== PLATFORM STATUS ====="
echo

echo "HTML Pages:"
find public -name "*.html" | wc -l

echo
echo "JS Files:"
find public -name "*.js" | wc -l

echo
echo "API Routes:"
find api -name "*.js" | wc -l

echo
echo "Database Tables:"
cat reports/platform-readiness.txt | grep "Tables Found"

echo
echo "Marketplace Pages:"
ls public/*marketplace*.html 2>/dev/null | wc -l

echo
echo "Dashboard Pages:"
ls public/*dashboard*.html 2>/dev/null | wc -l

echo
echo "Business Pages:"
ls public/business*.html 2>/dev/null | wc -l

echo
echo "Course Pages:"
find public/lessons -name "*.html" | wc -l
