#!/usr/bin/env node

import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { EOL } from "node:os";
import meow from "meow";

const cli = meow(
	`
    Usage
      $ node ./extractImage.mjs [options] <Dockerfile path> [key]

    Options
      --apply-variant, -a    Toggle whether to apply variant to tags or not. Type: boolean. Default: true

      --seperator, -s        What seperator to use for Array if [key] query is used. use "\\n" for newline. Type: string. Default: ", "

      --reverse-tags, -r     Reverse the tags array. Type: boolean. Default: false

      --help                 Print help menu
`, {
		importMeta: import.meta,
		flags: {
			applyVariant: {
				type: "boolean",
				alias: "a",
				default: true,
			},
			seperator: {
				type: "string",
				alias: "s",
				default: ", ",
			},
			reverseTags: {
				type: "boolean",
				alias: "r",
				default: false,
			},
		},
	},
);

const path = cli.input.at(0);
const key = cli.input.at(1);
const { applyVariant: variantApply, reverseTags, seperator } = cli.flags;

/** @param {string} string */
const getValue = string => /[^:]+$/.exec(string)?.at(0).trim();
/**
 * @param {string} string
 * @param {string} variant
 */
const applyVariant = (string, variant) => `${string}-${variant}`;

if (path) {
	const lines = readFileSync(resolve(path)).toString().split(EOL);

	const originalTags = getValue(lines.at(0))?.split(", ") ?? [];
	const variant = getValue(lines.at(1));
	const platforms = getValue(lines.at(2))?.split(", ") ?? [];
	const version = getValue(lines.at(3)).split("-").at(0);

	const semverArray = version.split(".");
	const versions = semverArray.map((_, i) => semverArray.slice(0, semverArray.length - i).join("."));

	const tags = [...versions, ...originalTags].map(t => (variantApply && variant ? applyVariant(t, variant) : t));

	const recipe = {
		tags: reverseTags ? tags.reverse() : tags,
		variant,
		platforms,
		version
	};

	if (key) {
		let value = recipe[key];
		if (value instanceof Array) value = value.join(seperator === "\\n" ? "\n" : seperator);

		console.info(value);
	} else {
		console.info(JSON.stringify(recipe, null, 4));
	}
} else {
	cli.showHelp(1);
}
