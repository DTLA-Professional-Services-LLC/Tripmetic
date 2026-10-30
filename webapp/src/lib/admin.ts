import { getIdTokenResult, type User } from "firebase/auth";

/**
 * Returns whether the signed-in user has the Firebase Auth `admin` claim.
 *
 * The claim is issued by the operator-controlled admin bootstrap script. The
 * client-side check only controls navigation; Cloud Functions independently
 * enforce the same claim for every privileged operation.
 */
export async function hasAdminClaim(user: User): Promise<boolean> {
  const token = await getIdTokenResult(user, true);
  return token.claims.admin === true;
}
