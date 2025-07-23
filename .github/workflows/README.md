# GitHub Workflows

This directory contains GitHub Actions workflows for the Material Theme Builder project.

## Workflows Overview

### 1. `web-build.yml` - Build Flutter Web App
**Triggers:** Push to main/develop, Pull requests to main, Manual dispatch

**Features:**
- Builds Flutter web app using Flutter v3.27.4
- Runs code analysis and tests
- Uploads build artifacts
- Auto-deploys to GitHub Pages on main branch pushes
- Cross-platform build matrix (Ubuntu, Windows, macOS)
- Separate lint job with strict analysis

### 2. `deploy-gh-pages.yml` - Deploy to GitHub Pages
**Triggers:** Push to main, Manual dispatch

**Features:**
- Dedicated GitHub Pages deployment
- Uses official GitHub Pages actions
- Proper permissions and concurrency handling
- CanvasKit renderer for better performance
- Configurable base href for GitHub Pages

### 3. `ci.yml` - Continuous Integration
**Triggers:** Pull requests, Push to develop

**Features:**
- Code formatting checks
- Comprehensive analysis with fatal warnings
- Test execution with coverage
- Build size monitoring
- Security vulnerability scanning with Trivy
- Coverage upload to Codecov

### 4. `release.yml` - Create Releases
**Triggers:** Git tags matching `v*.*.*`

**Features:**
- Automated release creation
- Web build archives (tar.gz and zip)
- Changelog extraction
- Release notes generation
- Asset uploads

## Configuration Files

### `dependabot.yml`
- Automatic dependency updates for Flutter/Dart packages
- GitHub Actions version updates
- Weekly schedule with proper reviewers and labels

## Setup Instructions

### 1. Enable GitHub Pages
1. Go to repository Settings > Pages
2. Select "GitHub Actions" as the source
3. The `deploy-gh-pages.yml` workflow will automatically deploy on main branch pushes

### 2. Configure Secrets (Optional)
No secrets are required for basic functionality, but you can add:
- `CODECOV_TOKEN` - For coverage reporting
- Custom deployment tokens if needed

### 3. Branch Protection (Recommended)
Set up branch protection rules:
- Require PR reviews
- Require status checks (CI workflow)
- Require branches to be up to date

## Workflow Dependencies

### Required Actions
- `actions/checkout@v4` - Code checkout
- `subosito/flutter-action@v2` - Flutter setup
- `actions/upload-artifact@v4` - Artifact upload
- `actions/configure-pages@v3` - GitHub Pages setup
- `actions/deploy-pages@v2` - GitHub Pages deployment

### Optional Actions
- `codecov/codecov-action@v3` - Coverage reporting
- `aquasecurity/trivy-action@master` - Security scanning
- `softprops/action-gh-release@v1` - Release creation

## Build Outputs

### Web Build
- Location: `build/web/`
- Renderer: CanvasKit (for better performance)
- CDN: Disabled (for better compatibility)
- Artifacts retained for 30 days (main builds) or 7 days (matrix builds)

### Release Assets
- `material-theme-builder-web-v*.*.*.tar.gz` - Compressed web build
- `material-theme-builder-web-v*.*.*.zip` - Zipped web build

## Monitoring

### Build Status
Check the Actions tab in GitHub repository for:
- Build success/failure status
- Test results
- Code coverage trends
- Security scan results

### Performance
- Build time optimization through caching
- Parallel job execution
- Conditional deployments

## Troubleshooting

### Common Issues
1. **Flutter version mismatch**: Ensure v3.27.4 compatibility
2. **Web build failures**: Check for web-specific dependencies
3. **GitHub Pages 404**: Verify base-href configuration
4. **Permission errors**: Check workflow permissions in repository settings

### Debug Steps
1. Check workflow logs in Actions tab
2. Verify Flutter version compatibility
3. Test build locally with same Flutter version
4. Check repository permissions and settings