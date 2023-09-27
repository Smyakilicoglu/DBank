import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'checkBalance' : () => Promise<number>,
  'cumpount' : () => Promise<undefined>,
  'topUp' : (arg_0: number) => Promise<undefined>,
  'withDrow' : (arg_0: number) => Promise<undefined>,
}
