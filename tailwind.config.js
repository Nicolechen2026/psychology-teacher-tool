/* Tailwind CSS 构建配置
 * 只输出 utilities，禁用 preflight（避免重置工作台原有组件样式）。
 * 重新构建：npx -y tailwindcss@3.4.17 -i styles/tailwind.input.css -o tailwind.css -c styles/tailwind.config.js --minify
 */
module.exports = {
  content: ['./index.html', './app.js'],
  corePlugins: { preflight: false },
  theme: {
    extend: {
      colors: {
        brand: {
          50: '#eef5ff',
          100: '#dceaff',
          200: '#bcd6ff',
          500: '#1f5fbf',
          600: '#1a52a8',
          700: '#164487',
          800: '#123673',
          900: '#0f2c5c'
        },
        ink: { 900: '#101828', 700: '#344054', 500: '#667085', 400: '#98a2b3' },
        mist: { 50: '#f8fafc', 100: '#f2f5f9', 200: '#e7edf4' }
      },
      boxShadow: {
        card: '0 1px 2px rgba(16,24,40,.04), 0 4px 14px rgba(16,24,40,.04)',
        lift: '0 6px 20px rgba(16,24,40,.10), 0 1px 3px rgba(16,24,40,.06)',
        btn: '0 1px 2px rgba(16,24,40,.08), 0 3px 8px rgba(26,82,168,.18)'
      },
      borderRadius: { xl2: '14px', xl3: '18px' }
    }
  },
  plugins: []
};
