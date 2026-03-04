#!/usr/bin/env node

/**
 * generate-index.js for AnySkill-Packs
 * 
 * Scans packs/{category}/{skill-name}/SKILL.md and produces index.json.
 */

const fs = require('fs');
const path = require('path');

const PACKS_DIR = path.join(__dirname, 'packs');
const INDEX_FILE = path.join(__dirname, 'index.json');

function extractFrontmatter(content) {
    const match = content.match(/^---\s*\n([\s\S]*?)\n---/);
    if (!match) return null;
    const result = {};
    for (const line of match[1].split('\n')) {
        const i = line.indexOf(':');
        if (i === -1) continue;
        result[line.substring(0, i).trim()] = line.substring(i + 1).trim().replace(/^["']|["']$/g, '');
    }
    return result;
}

function collectFiles(dir, baseDir) {
    const results = [];
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
        const full = path.join(dir, entry.name);
        if (entry.name === '.gitkeep') continue;
        if (entry.isDirectory()) results.push(...collectFiles(full, baseDir));
        else results.push(path.relative(baseDir, full));
    }
    return results;
}

function main() {
    const index = { packs: [] };
    const categories = fs.readdirSync(PACKS_DIR, { withFileTypes: true }).filter(e => e.isDirectory());

    for (const cat of categories) {
        const catDir = path.join(PACKS_DIR, cat.name);
        const skills = [];

        for (const skill of fs.readdirSync(catDir, { withFileTypes: true })) {
            if (!skill.isDirectory()) continue;
            const md = path.join(catDir, skill.name, 'SKILL.md');
            if (!fs.existsSync(md)) continue;

            const fm = extractFrontmatter(fs.readFileSync(md, 'utf-8'));
            if (!fm || !fm.name) continue;

            const files = collectFiles(path.join(catDir, skill.name), PACKS_DIR);
            files.sort();

            skills.push({
                name: fm.name,
                description: fm.description || '',
                path: `${cat.name}/${skill.name}`,
                file: `${cat.name}/${skill.name}/SKILL.md`,
                files,
            });

            console.log(`  ✅ ${fm.name} (${cat.name}/${skill.name}/)`);
        }

        if (skills.length > 0 || fs.readdirSync(catDir).filter(f => f !== '.gitkeep').length === 0) {
            index.packs.push({
                category: cat.name,
                skills,
            });
            console.log(`📂 ${cat.name}: ${skills.length} skill(s)`);
        }
    }

    fs.writeFileSync(INDEX_FILE, JSON.stringify(index, null, 2) + '\n', 'utf-8');
    console.log(`\n📦 Generated index.json with ${index.packs.reduce((s, p) => s + p.skills.length, 0)} skills across ${index.packs.length} packs.`);
}

main();
