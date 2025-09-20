/**
 * @see https://theme-plume.vuejs.press/config/navigation/ 查看文档了解配置详情
 *
 * Navbar 配置文件，它在 `.vuepress/plume.config.ts` 中被导入。
 */

import { defineNavbarConfig } from 'vuepress-theme-plume'

export default defineNavbarConfig([
  { text: '首页', link: '/', icon: 'mdi:home' },
  { text: '博客', link: '/blog/', icon: 'mdi:book' },
  { text: '标签', link: '/blog/tags/', icon: 'mdi:tag' },
  { text: '分类', link: '/blog/categories/', icon: 'mdi:folder-file' },
  { text: '归档', link: '/blog/archives/', icon: 'mdi:archive' },
  {
    text: '笔记',
    icon: 'mdi:file-document',
    items: [
      { text: '博客搭建指北', link: '/blog_construct/', icon: 'mdi:compass' },
      { text: '交易笔记', link: '/trading/', icon: 'mdi:trending-up' },
    ]
  },
  //导航栏添加示例如下
/**  {
    text: '技术文档',
    icon: 'mdi:idea',
    items: [
      {
        text: 'Vuepress Theme',
        icon: 'icon-park-solid:theme',
        items: [
          {
            text: 'vuepress-theme-plume',
            link: '/vuepress-theme-plume/',
            icon: 'mdi:paper-airplane',
            badge: '徽章'
          },
        ],
      },
      {
        text: 'Vuepress Plugin',
        icon: 'mingcute:plugin-2-fill',
        badge: { text: '徽章', type: 'warning' },
        items: [
          {
            text: 'caniuse',
            link: '/vuepress-plugin/caniuse/',
            icon: 'pajamas:feature-flag',
          },
          {
            text: 'auto-frontmatter',
            link: '/vuepress-plugin/auto-frontmatter/',
            icon: 'material-symbols:move-selection-down-rounded',
          },
          {
            text: 'blog-data',
            link: '/vuepress-plugin/blog-data/',
            icon: 'ic:baseline-post-add',
          },
          {
            text: 'notes-data',
            link: '/vuepress-plugin/notes-data/',
            icon: 'material-symbols:note-alt-rounded',
          },
          {
            text: 'shiki',
            link: '/vuepress-plugin/shiki/',
            icon: 'material-symbols-light:code-blocks-outline-rounded',
          },
        ],
      },
    ],
  },
*/

])
