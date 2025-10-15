// Simple script to run index.html in Playwright and print errors and logs to stdout

import { chromium } from 'playwright';
import { join } from 'path';

const __dirname = process.cwd();
const browser = await chromium.launch({
    args: ['--disable-web-security']
});
const page = await browser.newPage();
page.on('console', msg => console.log(msg.text()));
page.on('pageerror', msg => console.log(msg.message));
await page.goto('file://' + join(__dirname, 'index.html'), {
  waitUntil: 'domcontentloaded'
});
await browser.close();
