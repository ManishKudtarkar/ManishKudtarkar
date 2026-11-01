#!/usr/bin/env node

/**
 * GitHub Profile Validation Script
 * Validates the README.md structure and external links
 */

const fs = require('fs');
const path = require('path');

console.log('🚀 Starting GitHub Profile Validation...\n');

// Check if README.md exists
const readmePath = path.join(__dirname, 'README.md');
if (!fs.existsSync(readmePath)) {
    console.error('❌ README.md not found!');
    process.exit(1);
}

console.log('✅ README.md found');

// Read and validate README content
const readmeContent = fs.readFileSync(readmePath, 'utf8');

// Basic validation checks
const checks = [
    {
        name: 'Profile identity',
        test: () => readmeContent.includes('Manish Kudtarkar'),
        message: 'Profile identity (name present)'
    },
    {
        name: 'Skills section',
        test: () => /stack|Stack|technologies|Technologies/i.test(readmeContent),
        message: 'Technology stack section'
    },
    {
        name: 'Contact links',
        test: () => readmeContent.includes('linkedin.com') && readmeContent.includes('github.com'),
        message: 'Social media links'
    },
    {
        name: 'GitHub stats',
        test: () => readmeContent.includes('github-readme-stats'),
        message: 'GitHub statistics widgets'
    },
    {
        name: 'Live data section',
        test: () => readmeContent.includes('START_SECTION:waka') || readmeContent.includes('readme-typing-svg'),
        message: 'Live/auto-updating data section'
    },
    {
        name: 'Project showcase',
        test: () => readmeContent.includes('axflo.in') || readmeContent.includes('industrial-smart-grid'),
        message: 'Featured projects present'
    },
    {
        name: 'Contribution visualization',
        test: () => readmeContent.includes('github-contribution-grid-snake') || readmeContent.includes('activity-graph'),
        message: 'Contribution graph or snake animation'
    },
];

let passedChecks = 0;
checks.forEach(check => {
    if (check.test()) {
        console.log(`✅ ${check.message}`);
        passedChecks++;
    } else {
        console.log(`❌ ${check.message}`);
    }
});

console.log(`\n📊 Validation Results: ${passedChecks}/${checks.length} checks passed`);

if (passedChecks === checks.length) {
    console.log('🎉 All validations passed! Your GitHub profile is ready to shine!');
} else {
    console.log('⚠️  Some validations failed. Please review the issues above.');
}

// Check workflow files
const workflowDir = path.join(__dirname, '.github', 'workflows');
const snakePath = path.join(workflowDir, 'snake.yml');
const wakaPath  = path.join(workflowDir, 'waka.yml');

if (fs.existsSync(snakePath)) {
    console.log('✅ Snake animation workflow found');
    const snakeContent = fs.readFileSync(snakePath, 'utf8');
    if (snakeContent.includes('permissions:')) {
        console.log('✅ Snake workflow has proper permissions configured');
    } else {
        console.log('⚠️  Snake workflow might need permissions configuration');
    }
} else {
    console.log('❌ Snake animation workflow not found');
}

if (fs.existsSync(wakaPath)) {
    console.log('✅ WakaTime stats workflow found');
} else {
    console.log('⚠️  WakaTime workflow not found — coding stats will not auto-update');
}

console.log('\n🎯 Profile validation complete!');