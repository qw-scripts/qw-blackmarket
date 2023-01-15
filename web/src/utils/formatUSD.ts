const formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
});

export function formatAsUSD(amount: number): string {
  return formatter.format(amount);
}
