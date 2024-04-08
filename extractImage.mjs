#!/usr/bin/env node

import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { EOL } from "node:os";

const path = process.argv.at(2);
const key = process.argv.at(3);

const getValue = string => /[^:]+$/u.exec(string)?.at(0).trim();
const applyVariant = (string, variant) => `${string}-${variant}`;

const lines = readFileSync(resolve(path)).toString().split(EOL);
const originalTags = getValue(lines.at(0))?.split(", ") ?? [];
const variant = getValue(lines.at(1));

const version = getValue(lines.at(3)).split("-").at(0);
const semverArray = version.split(".");
const versions = semverArray.map((_, i) => semverArray.slice(0, semverArray.length - i).join("."));

const recipe = {
    tags: [...versions, ...originalTags].map(t => (applyVariant(t, variant))),
    variant,
    platforms: getValue(lines.at(2))?.split(", ") ?? [],
    version
};

if (key) {
	let value = recipe[key];
	if (value instanceof Array) value = value.join("\n");

	console.info(value);
} else {
	console.info(JSON.stringify(recipe, null, 4));
}
