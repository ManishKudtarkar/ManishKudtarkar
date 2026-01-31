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
        name: 'Header section',
        test: () => readmeContent.includes('Manish Kudtarkar'),
        message: 'Profile header with name'
    },
    {
        name: 'Skills section',
        test: () => readmeContent.includes('Technology Stack'),
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
        name: 'Animated elements',
        test: () => readmeContent.includes('readme-typing-svg'),
        message: 'Dynamic typing animations'
    }
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

// Check workflow file
const workflowPath = path.join(__dirname, '.github', 'workflows', 'snake.yml');
if (fs.existsSync(workflowPath)) {
    console.log('✅ GitHub Actions workflow found');
    const workflowContent = fs.readFileSync(workflowPath, 'utf8');
    
    if (workflowContent.includes('permissions:')) {
        console.log('✅ Workflow has proper permissions configured');
    } else {
        console.log('⚠️  Workflow might need permissions configuration');
    }
} else {
    console.log('❌ GitHub Actions workflow not found');
}

console.log('\n🎯 Profile validation complete!');