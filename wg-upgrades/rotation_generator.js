const users = [
  '@member_one',
  '@member_two',
  '@member_three',
  '@member_four',
  '@member_five'
];

const WEEKS = 52;
const start = new Date();

/* Generator */

let current = start;
let output = '| Member | Start | End |\n|-|-|-|\n';

function niceDate(d) {
  return `${d.getFullYear()}-${two(d.getMonth()+1)}-${two(d.getDate())}`;
}

function two(n) {
  if (n < 10) return `0${n}`;
  return n;
}

for (let week = 0; week <= WEEKS; week++) {
  const end = new Date(current.getTime() + (1000 * 60 * 60 * 24 * 5));
  output += `| ${users[week%users.length]} | ${niceDate(current)} | ${niceDate(end)} |\n`
  current = new Date(current.getTime() + (1000 * 60 * 60 * 24 * 7));
}

console.log(output);
