// Runtime deployment configuration. This file can be mounted/overwritten in
// Docker. An empty paymentSystem lets the app use its normal startup behavior.

window.appConfig = {
  paymentSystem: '',
  telegramGroupLink: '',
  matrixGroupLink: '',
  simplexGroupLink: '',
  signalGroupLink: ''
};

// Example configuration (uncomment and modify as needed):
// window.appConfig = {
//   paymentSystem: 'sk',
//   telegramGroupLink: 'https://t.me/+xSktv2JukXUxYmEx',
//   matrixGroupLink: 'https://matrix.to/#/#bitblik-offers:matrix.org',
//   simplexGroupLink: 'https://simplex.chat/contact#/?v=2-7&smp=...',
//   signalGroupLink: 'https://signal.group/#...'
// };
